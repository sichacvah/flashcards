class RenameReviewCountInCards < ActiveRecord::Migration
  def change
    rename_column :cards, :review_count, :true_answer_count
  end
end
