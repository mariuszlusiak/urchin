require 'net/http'

class Sms
  # Default Sender is me just for test
  def initialize(message,sender = 'INet')
    @message = message
    @sender =  sender
    put_in_the_queue
  end

  # Create message.log file and message_logger if it wasn't exist before
  def message_logger
    @@message_logger ||= Logger.new("#{Rails.root}/log/message.log")
  end

 # attr_reader :how_important
  # Touch the link :) and add log it
  def http_send(host,path,recipient)
    #raise "Error Message wa wa wa wa hoh hoh oh ho"

    # sending the message by HTTP
    response = Net::HTTP.get_response(host, path)

    begin
    recipient.response = response.body
    recipient.sent_at = Time.now
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
  
  def put_in_the_queue
    @message.ascii ? as_ascii : as_unicode
  end

  def as_unicode
    # UTF-8, HEX format with 4 digits
    a=[];@message.text.unpack('U*').each{|c| a << sprintf("%04x",c)};msg=a.join
    host = 'www.it2sms.com'
    @message.recipients.each do |recipient|  #Iterates on each number in the array
      path = "/sendsms/sendsms.asp?username=inet&password=inetsyria88212&mno=#{
      recipient.mobile_number}&Msg=#{msg}&sid=#{@sender}&fl=0&mt=1&ipcl=91.144.8.199"
      http_send host, path, recipient
    end
    
  end

  def as_ascii
    # Convert to URI encoding
    msg = CGI::escape(@message.text)
    host = 'www.it2sms.com'
    #Iterates on each number in the array
    @message.recipients.each do |recipient|
      path = "/sendsms/sendsms.asp?username=inet&password=inetsyria88212&mno=#{
      recipient.mobile_number}&Msg=#{msg}&sid=#{@sender}&fl=0&mt=0&ipcl=91.144.8.199"
      http_send host, path, recipient
    end
  end

  # Perform http_send by the queue
  handle_asynchronously :http_send #, :priority => Proc.new {|i| i.how_important }
end