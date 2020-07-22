class AddCityStateToCompanies < ActiveRecord::Migration[6.0]
  def change
    add_column :companies, :city,  :string, null: false
    add_column :companies, :state, :string, null: false
  end
end
