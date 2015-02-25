# encoding: UTF-8
class Card < ActiveRecord::Base
  validates :original_text, :translated_text, :review_date,
            presence: true
  validate :words_equal?
  before_validation :set_review_date, if: :new_record?

  scope :get_random_card, -> { 
    where("review_date < ?", Date.today).order("RANDOM()").first
  }

  def self.check_input(params)
    card = find(params[:id])
    if params[:user_input].squish.mb_chars.downcase.to_s == card.original_text.squish.mb_chars.downcase.to_s
      card.review_date += 3.days
      card.save!
    else
      false
    end
  end

  protected

  def set_review_date
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
