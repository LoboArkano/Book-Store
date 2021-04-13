class ChangeDataTypeForWallet < ActiveRecord::Migration[5.2]
  def self.up
    change_table :sellers do |t|
      t.change :wallet, :decimal, precision: 5, scale: 2, default: 0
    end
  end
  def self.down
    change_table :sellers do |t|
      t.change :wallet, :integer
    end
  end
end
