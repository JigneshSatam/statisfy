class AddColumnToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :cotent, :text
    add_column :questions, :question_type, :boolean
  end
end
