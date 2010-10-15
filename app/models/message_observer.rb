class MessageObserver < ActiveRecord::Observer
  require 'sms'

  # - Add sender id to the message
  # - Check if the text message is ASCII or NOT
  def before_validation(message)
    message.sender  = message.user.sender
    message.ascii = message.is_ascii?
  end

  # Create new SMS Object to send the message. See lib/sms.rb
  def after_create(message)
    Sms.new(message)
  end
end
