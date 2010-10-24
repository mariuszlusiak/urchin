class Message < ActiveRecord::Base
  belongs_to :user
  has_many :recipients

  # Every message should have a sender :D
  validates :user_id, presence:true 
  validates :recipients, presence:true
  validates :text, presence:true
  validates :sender, presence:true
  validates :unit, presence:true
  validate  :today_limit
  validate  :amount_limit
  validate  :valid_mobile_numbers?
  validate  :message_length

  # Must be float so number_of_units method can work
  Ascii_unit_lenght = 160.0
  Unicode_unit_lenght = 70.0


  Ascii_text_limit = 320
  Unicode_text_limit = 140
  
  # Returns the number of the messages would be sent
  def going_messages
    recipients.map(&:id).count * unit
  end

  # Validation methods

  #TODO need optimization user Global variables instead numbers in a configuration file
  def message_length
    if ascii
      errors.add_to_base("Sorry long message, should be less than #{Ascii_text_limit} characters.") if text.length > Ascii_text_limit
    else
      errors.add_to_base("Sorry long message, should be less than #{Unicode_text_limit} characters.") if text.length > Unicode_text_limit
    end
  end

  def valid_mobile_numbers?
    recipients.each do |recipient|
      unless recipient.mobile_number.match(/^\d+$/)
        errors.add_to_base("#{recipient.mobile_number} is invalid mobile number")
      end
    end
  end

  def today_limit
    errors.add_to_base("Sorry, you are out of your daly limit.") if going_messages > user.today_limit
  end
  
  def amount_limit
    errors.add_to_base("Sorry, you are out of your total messages limit.") if going_messages > user.amount_limit
  end

  # If your strings are Unicode (and they really should be, nowadays),
  # you can simply check that all code points are 127 or less.
  # The bottom 128 code points of Unicode are ASCII.
  def is_ascii?
    text.each_byte {|c| return 0 if c>=127}
    true
  end

  def number_of_units
    if ascii
      return  (text.length / Ascii_unit_lenght).ceil
    else
      return  (text.length / Unicode_unit_lenght).ceil
    end
  end
end
