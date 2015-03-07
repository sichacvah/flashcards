class User < ActiveRecord::Base
  has_many :cards, dependent: :destroy
  has_many :decks, dependent: :destroy
  has_many :authentications, dependent: :destroy
  belongs_to :current_deck, class_name: "Deck", foreign_key: "current_deck_id"
  accepts_nested_attributes_for :authentications

  validates :password, presence: true, confirmation: true,
                       length: { minimum: 3 },
                       on: :not_authentications
  validates :email, presence: true, uniqueness: true
  validates :password_confirmation, presence: true, on: :not_authentications

  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end

  def card_for_review
    if current_deck
      current_deck.cards.for_review.first
    else
      cards.for_review.first
    end
  end
end
