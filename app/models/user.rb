class User < ActiveRecord::Base
  has_many :messages
  has_many :packages, :through => :packages_users
  acts_as_authentic
  validates :name, presence:true
end
