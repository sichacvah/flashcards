class RenameTrueAnswerCountInCards < ActiveRecord::Migration
  def change
    rename_column :cards, :true_answer_count, :interval
  end
end
