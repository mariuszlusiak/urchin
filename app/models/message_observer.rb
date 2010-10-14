class MessageObserver < ActiveRecord::Observer
  require 'sms'

  def before_validation(message)
    # Add sender id to the message
    message.sender  = message.user.sender
  end

#  def after_validation(message)
#    message.errors.add(:recipients, :message => 'your message')
#  end

  def before_save(message)
    #message.force_encoding("UTF-8").ascii_only? ? message.encoding = 'ASCII' : message.encoding = 'UNICODE'
    # if Message text is only ASCII: return true else return false
    message.ascii = message.is_ascii?
  end

  def after_create(message)
    # Create new SMS Object to send the message. See lib/sms.rb
    Sms.new(message)
  end
end
