class AddColumnsToBuyer < ActiveRecord::Migration[5.2]
  def change
    add_column :buyers, :name, :string
    add_column :buyers, :address, :string
    add_column :buyers, :wallet, :decimal, precision: 5, scale: 2, default: 50
  end
end
