class CreatePackages < ActiveRecord::Migration
  def self.up
    create_table :packages do |t|
      t.string :name
      t.text :description
      t.integer :day_limit
      t.integer :amount
      t.integer :validity

      t.timestamps
    end
  end

  def self.down
    drop_table :packages
  end
end
