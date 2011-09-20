class Subscription < ActiveRecord::Base
  after_save :add_daily_limit, :add_units, :add_validity
  belongs_to :package
  belongs_to :user
  has_many :messages ,:through => :user
  #TODO add status and expiry date

  validates :package, presence:true
  validates :user, presence:true



  def add_daily_limit
    self.user.update_attribute(:daily_limit , self.package.day_limit + self.user.daily_limit)
  end

  def add_validity
    self.user.update_attribute(:validity , self.package.validity + self.user.validity)
  end

  def add_units
    self.user.update_attribute(:units , self.package.amount + self.user.units)
  end
  

end
# == Schema Information
#
# Table name: subscriptions
#
#  id         :integer(4)      not null, primary key
#  package_id :integer(4)      not null
#  user_id    :integer(4)      not null
#  created_at :datetime
#  updated_at :datetime
#

