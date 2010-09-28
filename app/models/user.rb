class User < ActiveRecord::Base
  has_many :messages
  acts_as_authentic
  validates :name, presence:true
end
