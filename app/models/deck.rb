class Deck < ActiveRecord::Base
  belongs_to :user
  has_many :cards
  def current?
    id == User.find_by_id(user_id).current_deck_id
  end
end
