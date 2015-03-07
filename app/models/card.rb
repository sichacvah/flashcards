class Card < ActiveRecord::Base
  has_attached_file :image, styles: { medium: "300x300>" }

  belongs_to :user
  belongs_to :deck
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  validates :original_text, :translated_text, :review_date, :deck, :user,
            presence: true
  validate :words_equal?
  before_validation :set_review_date, if: :new_record?

  scope :for_review, -> {
    where("review_date <= ?", DateTime.current).order("RANDOM()")
  }

  def check_translation(user_input)
    if prepare_word(user_input) == prepare_word(original_text)
      increase_review_date
    elsif try_count > 3
      reset_review_count
      false
    else
      increase_try_count
      false
    end
  end

  protected

  def review_config
    [DateTime.current + 12.hours,
     DateTime.current + 3.days,
     DateTime.current + 1.week,
     DateTime.current + 2.week,
     DateTime.current + 1.month]
  end

  def increase_try_count
    update_attribute(:try_count, try_count + 1)
  end

  def increase_review_date
    update_attributes(review_date: review_config[true_answer_count])
    increase_true_answer_count
  end

  def increase_true_answer_count
    if true_answer_count < review_config.length - 1
      update_attribute(:true_answer_count, true_answer_count + 1)
    end
  end

  def reset_review_count
    update_attribute(:true_answer_count, true_answer_count[0])
  end

  def set_review_date
    self.review_date = DateTime.current
  end

  def prepare_word(word)
    word.squish.mb_chars.downcase.to_s
  end

  def words_equal?
    if prepare_word(original_text) == prepare_word(translated_text)
      errors.add(:original_text,
                 "оригинальный текст не может быть таким же как и перевод")
      errors.add(:translated_text,
                 "оригинальный текст не может быть таким же как и перевод")
    end
  end
end
