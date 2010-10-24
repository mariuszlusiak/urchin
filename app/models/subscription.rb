class Subscription < ActiveRecord::Base
  belongs_to :package
  belongs_to :user
  has_many :recipients
  has_many :messages ,:through => :user
  #TODO add status and expiry date

  validates :package, presence:true
  validates :user, presence:true

  # Return the number of sent messages for today by this subscription
  def sent_messages_for_today
   recipients.where('recipients.created_at >= ? AND recipients.subscription_id = ?',
      Date.today.beginning_of_day,id).count
  end

  # Return the day limit number of this subscription
  def day_limit
    package.day_limit
  end

  def amount_limit
    package.amount
  end

  # Return the rest messages limit for today for this subscription
  def today_limit
    package.day_limit - sent_messages_for_today
  end
end
