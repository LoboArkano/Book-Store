class CreateSales < ActiveRecord::Migration[5.2]
  def change
    create_table :sales do |t|
      t.references :seller, foreign_key: true
      t.integer :book_id

      t.timestamps
    end
  end
end
