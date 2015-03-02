class AddAvatarToCards < ActiveRecord::Migration
  def self.up
    add_attachment :cards, :image
  end

  def self.down
    remove_attachment :cards, :image
  end
end
