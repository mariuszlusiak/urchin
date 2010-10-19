require 'net/http'

class Msg
  
  # Touch the link :) and add log it
  def self.perform(message_id,sender,host, path, recipient_id)
    # Create message.log file and message_logger if it wasn't exist before
    message_logger ||= Logger.new("#{Rails.root}/log/message.log")
    
    # You can rise error here, if you want to keep the message in the queue
    #raise "Error Message wa wa wa wa hoh hoh oh ho"
    # sending the message by HTTP
    response = Net::HTTP.get_response(host, path)

    begin
      recipient = Recipient.find(recipient_id)
      recipient.response = response.body
      recipient.sent_at = Time.zone.now
      recipient.save
      message = Message.find(message_id)
      # Logging
      log = "Message [#{
      message.id}]:\n\tSender id: #{
      message.user_id}\n\tSender Name: #{
      sender}\n\tText: \"#{
      message.text}\"\n\tEnglish(ASCII): #{
      message.ascii}\n\tUser Sent it at: #{
      message.created_at}\n\tSystem sent it at: #{
      recipient.sent_at}\n\tRespone:\n\t\tBody: #{response.body}\n\t\tCode: #{response.code}\n"
      message_logger.info(log)

      #message_logger.info("http://"+host+path)
      #message_logger.info(@message.to_yaml + response.to_yaml + @sender.to_yaml + "\n")# Log recored
    rescue Exception => e
      message_logger.error(e.message + '/n' + e.backtrace.inspect)
    end
  end
end

class Sms
  # Default Sender is me just for test
  def initialize(message)
    @message = message
    @sender =  @message.sender # add the sender ID
    send_to_queue
  end

#  # Create message.log file and message_logger if it wasn't exist before
#  def message_logger
#    @@message_logger ||= Logger.new("#{Rails.root}/log/message.log")
#  end

  # Convert UTF-8 Message text to HEX formatted in 4 digits
  def as_unicode
    a=[];@message.text.unpack('U*').each{|c| a << sprintf("%04x",c)};a.join
  end
  # Convert Message to URI encoding
  def as_ascii
    CGI::escape(@message.text)
  end

  def send_to_queue
    # Host name
    host = 'www.it2sms.com'

    # Choose the encoding type
    @message.ascii ? (msg,mt = as_ascii,0) : (msg,mt = as_unicode,1)

    # Create Queue Name
    queue = 'queue_' + @message.user.id.to_s

    # Iterates on each number in the array
    @message.recipients.each do |recipient|
      path = "/sendsms/sendsms.asp?username=inet&password=inetsyria88212&mno=#{
      recipient.mobile_number}&Msg=#{msg}&sid=#{@sender}&fl=0&mt=#{mt}&ipcl=91.144.8.199"
      Resque::Job.create(queue, Msg, @message.id,@sender, host, path, recipient.id)
    end
  end
end