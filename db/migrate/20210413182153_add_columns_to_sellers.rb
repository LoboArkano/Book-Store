class AddColumnsToSellers < ActiveRecord::Migration[5.2]
  def change
    add_column :sellers, :name, :string
    add_column :sellers, :phone, :string
    add_column :sellers, :wallet, :integer
  end
end
