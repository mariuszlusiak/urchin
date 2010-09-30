class CreateRecipients < ActiveRecord::Migration
  def self.up
    create_table :recipients do |t|
      t.string :mobile_number,  null:false
      t.string :response
      t.references :message,    null:false
      t.datetime :sent_at
      t.datetime :received_at

      t.timestamps
    end
  end

  def self.down
    drop_table :recipients
  end
end
