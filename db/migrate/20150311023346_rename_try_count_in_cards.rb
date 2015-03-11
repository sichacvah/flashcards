class RenameTryCountInCards < ActiveRecord::Migration
  def change
    rename_column :cards, :try_count, :quality
  end
end
