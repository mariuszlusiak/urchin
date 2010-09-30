class User < ActiveRecord::Base
  has_many :messages

  has_many :subscriptions
  has_many :packages, through:'subscriptions'

  acts_as_authentic
  validates :name, presence:true
end
