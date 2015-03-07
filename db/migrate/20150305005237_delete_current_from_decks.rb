class DeleteCurrentFromDecks < ActiveRecord::Migration
  def change
    remove_column :decks, :current, :boolean
  end
end
