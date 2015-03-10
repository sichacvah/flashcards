class ChangeLocaleInUser < ActiveRecord::Migration
  def change
    change_column :users, :locale, :string, default: :ru
  end
end
