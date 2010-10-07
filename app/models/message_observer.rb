class MessageObserver < ActiveRecord::Observer
  require 'sms'

  def after_create(message)
    Sms.new(message)
  end

  # if Message text is only ASCII: return true else return false
  def before_save(message)
    #message.force_encoding("UTF-8").ascii_only? ? message.encoding = 'ASCII' : message.encoding = 'UNICODE'
    message.ascii = message.is_ascii?
  end
end
