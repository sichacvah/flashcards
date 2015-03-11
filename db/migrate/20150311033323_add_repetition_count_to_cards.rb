class AddRepetitionCountToCards < ActiveRecord::Migration
  def change
    add_column :cards, :repetition_count, :integer, default: 0
  end
end
