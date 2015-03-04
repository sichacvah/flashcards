class ChangeDeckCurrent < ActiveRecord::Migration
  def change
    change_column :decks, :current, :boolean, default: false
  end
end
