class User < ActiveRecord::Base
  has_many :messages
  has_many :recipients, :through => :messages

  has_many :subscriptions
  has_many :packages, :through => :subscriptions

  acts_as_authentic

  validates :name, :presence => true
  validates :sender, :presence => true #TODO add regex validation
  

  # Returns the number of sent messages by this user today.
  # Not used now
  #def sent_messages_for_today(user=self)
  #  Recipient.user_recipients_of_today(user).count
  #end



  def today_limit
    self.daily_limit
  end
  
  def units_limit
    self.units
  end

  def minus_units(recipient)
    self.update_attribute(:units,self.units - recipient.message.unit)
  end

  def minus_daily_limit(recipient)
    self.update_attribute(:daily_limit,self.daily_limit - recipient.message.unit)
  end


  # Gateway  Errors Numbers :)
  # -------------------------------------------
  # 0000		Message not sent.
  # 200304174210838 Message sent successfully.
  # 0005		Invalid server
  # 0010		Username not provided.
  # 0011		Password not provided.
  # 00		Invalid username/password.
  # 0020		Insufficient Credits
  # 0030		Invalid Sender ID
  # 0040		Mobile number not provided.
  # 0041		Invalid mobile number.
  # 0042		Network not supported.
  # 0050		Invalid message.
  # 0060		Invalid quantity specified.
  # 0066		Network not supported
  #
  # All errors IDS smaller than 100 that why  "recipients.response < 100"
  # P.S. NOt used yet
  #def not_sent_messages
  #  recipients.where("recipients.response IS NULL OR recipients.response < 100")
  #end


end
# == Schema Information
#
# Table name: users
#
#  id                  :integer(4)      not null, primary key
#  name                :string(255)     not null
#  login               :string(255)     not null
#  email               :string(255)     not null
#  sender              :string(255)     not null
#  crypted_password    :string(255)     not null
#  password_salt       :string(255)     not null
#  persistence_token   :string(255)     not null
#  single_access_token :string(255)     not null
#  perishable_token    :string(255)     not null
#  login_count         :integer(4)      default(0), not null
#  failed_login_count  :integer(4)      default(0), not null
#  last_request_at     :datetime
#  current_login_at    :datetime
#  last_login_at       :datetime
#  current_login_ip    :string(255)
#  last_login_ip       :string(255)
#  daily_limit         :integer(4)      default(0)
#  units               :integer(4)      default(0)
#  validity            :integer(4)      default(0)
#  created_at          :datetime
#  updated_at          :datetime
#

