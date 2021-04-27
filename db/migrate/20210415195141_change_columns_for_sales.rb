class ChangeColumnsForSales < ActiveRecord::Migration[5.2]
  def change
    add_column :sales, :book_title, :string
    add_column :sales, :book_price, :decimal, precision: 5, scale: 2
    add_column :sales, :profit, :decimal, precision: 5, scale: 2
    remove_column :sales, :book_id
  end
end
