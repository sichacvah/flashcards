class AddReviewCountToCard < ActiveRecord::Migration
  def change
    add_column :cards, :review_count, :integer
  end
end
