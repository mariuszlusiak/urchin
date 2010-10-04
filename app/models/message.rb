class Message < ActiveRecord::Base
  belongs_to :user
  has_many :recipients
  
  # Every message should have a sender :D
  validates :user_id, presence:true 
  validates :recipients, presence:true
  validates :text, presence:true
  validate  :today_limit
  validate  :amount_limit

  # Returns the number of the messages would be sent
  def going_messages
    recipients.map(&:id).count
  end

  def today_limit
    errors.add_to_base("Sorry, you are out of your daly limit.") if going_messages > user.today_limit
  end
  
  def amount_limit
    errors.add_to_base("Sorry, you are out of your messages limit.") if going_messages > user.amount_limit
  end
  
  # If your strings are Unicode (and they really should be, nowadays),
  # you can simply check that all code points are 127 or less.
  # The bottom 128 code points of Unicode are ASCII.
  def is_ascii?
    text.each_byte {|c| return 0 if c>=127}
    true
  end
end
