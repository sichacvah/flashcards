class Deck < ActiveRecord::Base
  belongs_to :user
  has_many :cards

  scope :get_current, ->{ where('current = true') }

  def falsify_all_others
    self.class.where('id != ? and current', self.id).update_all("current=false")
  end
end
