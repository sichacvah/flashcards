class ChangeReviewDateFormatInCards < ActiveRecord::Migration
  def up
    change_column :cards, :review_date, :datetime
  end

  def down
    change_column :cards, :review_date, :date
  end
end
