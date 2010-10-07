class Subscription < ActiveRecord::Base
  belongs_to :package
  belongs_to :user
  has_many :recipients
  #TODO add status and expiry date

  validates :package, presence:true
  validates :user, presence:true

  def going_messages
   recipients.where('recipients.created_at >= ? AND recipients.subscription_id = ?',
      Date.today.beginning_of_day,id).count
  end

  def day_limit
    package.day_limit
  end

  def today_limit
    package.day_limit - going_messages
  end
end
