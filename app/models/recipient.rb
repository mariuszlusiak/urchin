class Recipient < ActiveRecord::Base
  after_save :minus_units,:minus_daily_limit
  belongs_to :message
  belongs_to :user

  scope :user_recipients_of_today, lambda { |user| user.recipients.where('messages.created_at >= ? ', Date.today.beginning_of_day)}
  scope :recipients_of_message, lambda { |message| message.recipients }

  # This Validation is already exist in Message Model under the method :valid_mobile_numbers?
  # I choose to stope this validation rather than Message Model validation
  # to prevent double check and to have better Error message for Invalid Mobile number
  #validates :mobile_number, :numericality => true, :presence => true

  #TODO Errors like 00 ,0010 and 0011 should don't appear to normal user
  Gateway_Errors = {
    '0000'	=>	'Message not sent.',
    '0005'	=>	'Invalid server',
    '0010'	=>	'Username not provided.',
    '0011'	=>	'Password not provided.',
    '00'    =>	'Invalid username/password.',
    '0020'	=>	'Insufficient Credits',
    '0030'	=>	'Invalid Sender ID',
    '0040'	=>	'Mobile number not provided.',
    '0041'	=>	'Invalid mobile number.',
    '0042'	=>	'Network not supported.',
    '0050'	=>	'Invalid message.',
    '0060'	=>	'Invalid quantity specified.',
    '0066'	=>	'Network not supported',
    nil => 'Pending' # this why I love Ruby
  }

  def status
    response.to_i > 100 ? 'Sent successfully.' : Gateway_Errors[response]
  end

  def minus_units
    self.message.user.minus_units self
  end

  def minus_daily_limit
    self.message.user.minus_daily_limit self
  end

end
# == Schema Information
#
# Table name: recipients
#
#  id              :integer(4)      not null, primary key
#  mobile_number   :string(255)     not null
#  response        :string(255)
#  message_id      :integer(4)      not null
#  subscription_id :integer(4)      not null
#  sent_at         :datetime
#  received_at     :datetime
#  created_at      :datetime
#  updated_at      :datetime
#

