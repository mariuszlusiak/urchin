class User < ActiveRecord::Base
  has_many :messages

  has_many :subscriptions
  has_many :packages, :through => :subscriptions

  acts_as_authentic
  validates :name, presence:true

  def sent_messages_for_today
    messages.where('messages.created_at >= ? ', Date.today.beginning_of_day).count
  end

  def day_limit
    n=0
    packages.each {|p| n += p.day_limit}
    n 
  end

  def total_limit
    n=0
    packages.each {|p| n += p.amount}
    n - messages.count #TODO it must be only the unexpired(valid) subscriptions for this user
  end

  def today_limit
    day_limit - sent_messages_for_today
  end
end
