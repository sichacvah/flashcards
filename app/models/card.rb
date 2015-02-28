class Card < ActiveRecord::Base
  belongs_to :user
  validates :original_text, :translated_text, :review_date, :user
            presence: true
  validate :words_equal?
  before_validation :set_review_date, if: :new_record?

  scope :cards_for_review, -> {
    where("review_date <= ?", Date.today).order("RANDOM()")
  }

  def check_translation(user_input)
    if prepare_word(user_input) == prepare_word(original_text)
      update_attribute(:review_date, review_date + 3.days)
    else
      false
    end
  end

  protected

  def set_review_date
    self.review_date = Date.today + 3.days
  end

  def prepare_word(word)
    word.squish.mb_chars.downcase.to_s
  end

  def words_equal?
    if prepare_word(original_text) == prepare_word(translated_text)
      errors.add(:original_text, "original text can't be equal transalted text ")
      errors.add(:translated_text, "translated text can't be equal original text")
    end
  end
end
