class Card < ActiveRecord::Base
  validates :original_text, :translated_text, :review_date,
            presence: true
  validate :words_equal?
  before_validation :set_review_date

  protected

  def set_review_date
    unless self.review_date.present?
      self.review_date = Date.today + 3.days
  end

  def prepare_word(word)
    word.strip.mb_chars.downcase.to_s
  end

  def words_equal?
    if prepare_word(original_text) == prepare_word(translated_text)
      errors.add(:original_text, "original text can't be equal transalted text ")
      errors.add(:translated_text, "translated text can't be equal original text")
    end
  end
end
