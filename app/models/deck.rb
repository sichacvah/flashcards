class Deck < ActiveRecord::Base
  belongs_to :user
  has_many :cards
  def current?
    self == user.current_deck
  end
end
