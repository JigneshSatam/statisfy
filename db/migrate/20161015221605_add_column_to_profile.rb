class AddColumnToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :email, :string
    add_column :profiles, :photo, :text
  end
end
