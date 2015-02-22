class Card < ActiveRecord::Base
  include ActiveModel::Validations  
  validates :original_text, :translated_text, :review_date,
            presence: true
  validate :words_equal?
  before_validation :set_review_date


  protected


  def set_review_date
    current_date = Date.current
    self.review_date = current_date.change(day: current_date.day + 3)
  end

  def prepare_word(word)
    word.strip.mb_chars.downcase.to_s
  end

  def words_equal?
    if prepare_word(original_text) == prepare_word(translated_text)
      errors[:base] << "перевод не может быть равен оригиналу"
    end
  end
end
