class AddColumnsToAnswer < ActiveRecord::Migration
  def change
    add_column :answers, :cotent, :text
  end
end
