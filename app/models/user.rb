class User < ActiveRecord::Base
  has_many :messages
  has_many :recipients, :through => :messages

  has_many :subscriptions
  has_many :packages, :through => :subscriptions

  acts_as_authentic
  validates :name, presence:true

  # Returns the number of sent messages by this user for today
  def sent_messages_for_today
    recipients.where('recipients.created_at >= ? ', Date.today.beginning_of_day).count
  end

  # Returns the number of sent messages by this user for all the time
  #TODO it must be only the valid (unexpired) subscriptions for this user
  def sent_messages_number
    recipients.count
  end

  # Returns the fixed Day limit, this function add all day limits for this user
  # subscriptions
  # TODO don't count the expired subscriptions
  def day_limit
    packages.map(&:day_limit).sum
  end

  # Returns total amount limit for this user
  def amount_limit
    #TODO it must be only the valid (unexpired) subscriptions for this user
    packages.map(&:amount).sum - sent_messages_number
  end

  # Returns the final limit for today by counting sent messages for today
  def today_limit
    day_limit - sent_messages_for_today
  end


end
