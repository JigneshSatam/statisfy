class AddProfileToSurvey < ActiveRecord::Migration
  def change
    add_column :surveys, :profile_id, :integer
  end
end
