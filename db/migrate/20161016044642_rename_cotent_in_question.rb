class RenameCotentInQuestion < ActiveRecord::Migration
  def change
    rename_column :questions, :cotent, :content
    rename_column :answers, :cotent, :content
  end
end
