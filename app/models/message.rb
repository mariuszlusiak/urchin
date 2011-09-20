class Message < ActiveRecord::Base
  require 'sms'

  belongs_to :user
  has_many :recipients

  before_validation :set_ascii,:set_sender,:set_unit
  after_create :send_sms

  # Every message should have a sender :D
  validates :user_id, :presence => true
  validates :recipients, :presence => true
  validates :text, :presence => true
  validates :sender, :presence => true
  validates :unit, :presence => true
  validate :user_has_enough_daily_units
  validate :user_has_enough_units
  validate :valid_mobile_numbers?
  validate :message_length



  #def user_daily_limit
  #  errors.add(:base, "Sorry, you are out of your daily limit.") if (self.user.daily_limit <= self.needed_units)
  #end


  # Must be float so number_of_units method can work
  Ascii_unit_lenght = 160.0
  Unicode_unit_lenght = 70.0


  Ascii_text_limit = 320
  Unicode_text_limit = 140


  # Returns the number of the messages (units) would be sent
  def needed_units
    Recipient.recipients_of_message(self).count * self.unit
  end

  # Validation methods

  #TODO need optimization user Global variables instead numbers in a configuration file
  def message_length
    if self.ascii
      errors.add(:base, "Sorry long message, should be less than #{Ascii_text_limit} characters.") if text.length > Ascii_text_limit
    else
      errors.add(:base, "Sorry long message, should be less than #{Unicode_text_limit} characters.") if text.length > Unicode_text_limit
    end
  end


  # If your strings are Unicode (and they really should be, nowadays),
  # you can simply check that all code points are 127 or less.
  # The bottom 128 code points of Unicode are ASCII.
  def is_ascii?
    text.each_byte { |c| return false if c>=127 }
    true
  end

  # Return the unites of the message
  def number_of_units
    if self.ascii
      return (self.text.length / Ascii_unit_lenght).ceil
    else
      return (self.text.length / Unicode_unit_lenght).ceil
    end
  end


  def valid_mobile_numbers?
    recipients.each do |recipient|
      unless recipient.mobile_number.match(/^\d+$/)
        errors.add(:base, "#{recipient.mobile_number} is invalid mobile number")
      end
    end
  end

  def user_has_enough_daily_units
    errors.add(:base, "Sorry, you are out of your daly limit.") if needed_units > user.daily_limit
  end

  def user_has_enough_units
    errors.add(:base, "Sorry, you are out of your total messages limit.") if needed_units > user.units_limit
  end

  # - Add sender id to the message
  def set_sender
    self.sender = self.user.sender
  end

  # - Check if the text message is ASCII or NOT
  def set_ascii
    self.ascii = self.is_ascii?
  end

  # set the number of units needed for this message 1,2 or 3
  def set_unit
    self.unit = self.number_of_units
  end

  # Create new SMS Object to send the message. See lib/sms.rb
  def send_sms
    Sms.new(self)
  end

end
# == Schema Information
#
# Table name: messages
#
#  id         :integer(4)      not null, primary key
#  text       :string(255)
#  sender     :string(255)     not null
#  ascii      :boolean(1)
#  unit       :integer(4)      not null
#  user_id    :integer(4)      not null
#  created_at :datetime
#  updated_at :datetime
#

