class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages do |t|
      t.string :text
      t.string :sender, null:false
      t.boolean :ascii
      t.integer :unit, null:false
      t.references :user , null:false

      t.timestamps
    end

    add_index :messages,:user_id
  end

  def self.down
    drop_table :messages
  end
end
