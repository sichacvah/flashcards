class ChangeEFactorToCards < ActiveRecord::Migration
  def change
    change_column :cards, :e_factor, :float, default: 2.5
  end
end
