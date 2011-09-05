require 'net/http'

class Sms
  # Default Sender is me just for test
  def initialize(message)
    @message = message
    @sender =  message.sender # add the sender ID
    send_sms
  end

  # Create message.log file and message_logger if it wasn't exist before
  def message_logger
    @@message_logger ||= Logger.new("#{Rails.root}/log/message.log")
  end

  # Touch the link :) and add log it
  def http_send(host,path,recipient)
    # You can rise error here, if you want to keep the message in the queue
    #raise "Error Message wa wa wa wa hoh hoh oh ho"
    # sending the message by HTTP
    response = Net::HTTP.get_response(host, path)
    
    begin
      recipient.response = response.body
      recipient.sent_at = Time.zone.now
      recipient.save
      # Logging
      log = "Message [#{
      @message.id}]:\n\tSender id: #{
      @message.user_id}\n\tSender Name: #{
      @sender}\n\tText: \"#{
      @message.text}\"\n\tEnglish(ASCII): #{
      @message.ascii}\n\tSent at: #{
      @message.sent_at}\n\tRespone:\n\t\tBody: #{response.body}\n\t\tCode: #{response.code}\n"
      message_logger.info(log)
    
      #message_logger.info("http://"+host+path)
      #message_logger.info(@message.to_yaml + response.to_yaml + @sender.to_yaml + "\n")# Log recored
    rescue Exception => e
      message_logger.error(e.message + '/n' + e.backtrace.inspect)
    end
  end

  # Convert UTF-8 Message text to HEX formatted in 4 digits
  def as_unicode
    a=[];@message.text.unpack('U*').each{|c| a << sprintf("%04x",c)};a.join
  end
  # Convert Message to URI encoding
  def as_ascii
    CGI::escape(@message.text)
  end

  def send_sms
    # Choose the encoding type
    @message.ascii ? (msg,mt = as_ascii,0) : (msg,mt = as_unicode,1)

     host = 'www.thehttpsmsgateway.com'
    # Iterates on each number in the array
    @message.recipients.each do |recipient|  #Iterates on each number in the array
      path = "/url/path/#{recipient.mobile_number}&Msg=#{msg}&sid=#{@sender}&fl=0&mt=#{mt}"
      
      http_send host, path, recipient
    end
  end

  # Perform http_send by the queue
  handle_asynchronously :http_send
end