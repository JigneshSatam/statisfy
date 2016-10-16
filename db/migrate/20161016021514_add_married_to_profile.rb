class AddMarriedToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :married, :boolean, default: false
  end
end
