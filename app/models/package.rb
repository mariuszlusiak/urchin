class Package < ActiveRecord::Base
  has_many :subscriptions
  has_many :packages, :through => :subscriptions

  validates :name,      presence:true, uniqueness:true
  validates :day_limit, presence:true
  validates :amount,    presence:true
end
