class ChangeIntervalInCards < ActiveRecord::Migration
  def up
    change_column :cards, :interval, :integer
  end

  def down
    change_column :cards, :interval, :float
  end
end
