class AddCompanyToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :company, :string
  end
end
