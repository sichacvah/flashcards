class AddEFactorToCards < ActiveRecord::Migration
  def change
    add_column :cards, :e_factor, :float
  end
end
