class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :first_name
      t.string :last_name
      t.text :address
      t.integer :salary
      t.integer :age
      t.integer :experience
      t.string :highest_qualification
      t.string :organization

      t.timestamps null: false
    end
  end
end
