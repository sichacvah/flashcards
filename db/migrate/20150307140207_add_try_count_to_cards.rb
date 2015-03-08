class AddTryCountToCards < ActiveRecord::Migration
  def change
    add_column :cards, :try_count, :integer, default: 0
  end
end
