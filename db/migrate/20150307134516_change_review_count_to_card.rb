class ChangeReviewCountToCard < ActiveRecord::Migration
  def change
    change_column :cards, :review_count, :integer, default: 0
  end
end
