class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.references :seller, foreign_key: true
      t.string :title
      t.text :description
      t.string :author
      t.decimal :price, precision: 5, scale: 2, default: 1
      t.integer :stock, default: 1
      t.string :image

      t.timestamps
    end
  end
end
