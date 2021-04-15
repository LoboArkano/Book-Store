class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.references :buyer, foreign_key: true
      t.integer :book_id

      t.timestamps
    end
  end
end
