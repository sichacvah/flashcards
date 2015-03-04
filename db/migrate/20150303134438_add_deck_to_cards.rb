class AddDeckToCards < ActiveRecord::Migration
  def change
    add_column :cards, :deck_id, :integer
  end
end
