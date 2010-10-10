class MessageObserver < ActiveRecord::Observer
  require 'sms'

  def after_create(message)
    Sms.new(message)
  end

  def before_save(message)
    # Add sending time to the message
    message.sent_at = Time.now
    #message.force_encoding("UTF-8").ascii_only? ? message.encoding = 'ASCII' : message.encoding = 'UNICODE'
    # if Message text is only ASCII: return true else return false
    message.ascii = message.is_ascii?
  end
end
