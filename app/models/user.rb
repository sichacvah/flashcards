class User < ActiveRecord::Base
  has_many :cards, dependent: :destroy
  has_many :decks, dependent: :destroy
  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications

  validates :password, presence: true, confirmation: true,
                       length: { minimum: 3 },
                       on: :not_authentications
  validates :email, presence: true, uniqueness: true
  validates :password_confirmation, presence: true, on: :not_authentications
  belongs_to :current_deck

  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end
end
