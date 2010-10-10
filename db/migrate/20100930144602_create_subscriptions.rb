class CreateSubscriptions < ActiveRecord::Migration
  def self.up
    create_table :subscriptions do |t|
      t.references :package, :foreign_key => {:dependent => :delete},  null:false
      t.references :user, :foreign_key => {:dependent => :delete},  null:false

      t.timestamps
    end


    add_index :subscriptions, :package_id
    add_index :subscriptions, :user_id
  end

  def self.down
    drop_table :subscriptions
  end
end
