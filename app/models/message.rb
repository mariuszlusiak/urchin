class Message < ActiveRecord::Base
  belongs_to :user
  has_many :recipients
  
  # Every message should have a sender :D
  validates :user_id, presence:true 
  validates :recipients, presence:true
  validates :text, presence:true
  validate  :messages_limits

  # Returns the number of the messages would be sent
  def going_messages
    recipients.map(&:id).count
  end

  def messages_limits
    today_limit = user.today_limit
    amount_limit = user.amount_limit
    messages_to_be_sent = going_messages
    
    if messages_to_be_sent > amount_limit
      errors.add_to_base("Sorry, you are out of your messages limit.")
    end


    if messages_to_be_sent > today_limit
      errors.add_to_base("Sorry, you are out of your daly limit.")
    end






#    unless user.today_limit > 0
#      errors.add_to_base("Sorry, you are out of your daly limit.")
#    end



    #errors.add_to_base("Sorry, you are out of your messages limit.") unless user.amount_limit > 0
  end
  
  # If your strings are Unicode (and they really should be, nowadays),
  # you can simply check that all code points are 127 or less.
  # The bottom 128 code points of Unicode are ASCII.
  def is_ascii?
    text.each_byte {|c| return 0 if c>=127}
    true
  end
end
