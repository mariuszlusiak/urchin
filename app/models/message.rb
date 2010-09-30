class Message < ActiveRecord::Base
  belongs_to :user
  has_many :recipients
  
  # Every message should have a sender :D
  validates :user_id, presence:true 
  validates :recipients, presence:true
  validates :text, presence:true
  
  # If your strings are Unicode (and they really should be, nowadays),
  # you can simply check that all code points are 127 or less.
  # The bottom 128 code points of Unicode are ASCII.
  def is_ascii?
    text.each_byte {|c| return 0 if c>=127}
    true
  end
end
