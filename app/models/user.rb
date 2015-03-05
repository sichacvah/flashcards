class User < ActiveRecord::Base
  has_many :cards, dependent: :destroy
  has_many :decks, dependent: :destroy
  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications

  validates :password, presence: true, confirmation: true,
                       length: { minimum: 3 },
                       unless: :with_authentications
  validates :email, presence: true, uniqueness: true
  validates :password_confirmation, presence: true, unless: :with_authentications
  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end

  def with_authentications
    authentications.present?
  end
end
