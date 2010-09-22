class User < ActiveRecord::Base
  has_many :messages
  acts_as_authentic
end
