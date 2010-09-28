class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages do |t|
      t.string :text
      t.boolean :ascii
      t.datetime :sent_at, null:false
      t.references :user , null:false

      t.timestamps
    end

    add_index :messages,:user_id
  end

  def self.down
    drop_table :messages
  end
end
