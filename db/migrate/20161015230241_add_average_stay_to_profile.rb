class AddAverageStayToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :average_stay, :integer
  end
end
