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

  def check_translation(user_input, time_to_answer)
    compare_result = compare_text(prepare_word(user_input),
                                  prepare_word(original_text))
    time_to_answer = nil if compare_result == :failed
    super_memo = SuperMemo.new(interval, e_factor,
                               repetition_count, time_to_answer)
    update_attributes(super_memo.get_repetition)
    compare_result
  end

  protected

  def compare_text(user_input, original_text)
    distance = Text::Levenshtein.distance(user_input, original_text)
    if distance == 0
      :success
    elsif (distance == 3 && original_text.length >= 10) ||
          (distance == 2 && original_text.length >= 8) ||
          (distance == 1 && original_text.length >= 3)
      :incomplete_match
    else
      :failed
    end
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
