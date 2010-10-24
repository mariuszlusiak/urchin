class User < ActiveRecord::Base
  has_many :messages
  has_many :recipients, :through => :messages

  has_many :subscriptions
  has_many :packages, :through => :subscriptions

  acts_as_authentic
  validates :name, presence:true
  validates :sender, presence:true #TODO add regex validation

  Gateway_Errors = {
    '0000'	=>	'Message not sent.',
    '0005'	=>	'Invalid server',
    '0010'	=>	'Username not provided.',
    '0011'	=>	'Password not provided.',
    '00'    =>	'Invalid username/password.',
    '0020'	=>	'Insufficient Credits',
    '0030'	=>	'Invalid Sender ID',
    '0040'	=>	'Mobile number not provided.',
    '0041'	=>	'Invalid mobile number.',
    '0042'	=>	'Network not supported.',
    '0050'	=>	'Invalid message.',
    '0060'	=>	'Invalid quantity specified.',
    '0066'	=>	'Network not supported',
    :nil => 'pending'
  }

  def pending_messages
    recipients.where(:response => nil)
  end

  def failed_messages
    # 0000		Message not sent.
    # 200304174210838 Message sent successfully.
    # 0005		Invalid server
    # 0010		Username not provided.
    # 0011		Password not provided.
    # 00		Invalid username/password.
    # 0020		Insufficient Credits
    # 0030		Invalid Sender ID
    # 0040		Mobile number not provided.
    # 0041		Invalid mobile number.
    # 0042		Network not supported.
    # 0050		Invalid message.
    # 0060		Invalid quantity specified.
    # 0066		Network not supported
    #
    # All errors IDS smaller than 100 that why  "recipients.response < 100"

    #TODO need test
    recipients.where("recipients.response < 100 OR recipients.response = ?",nil).limit(5).order("created_at DESC")
  end

  #TODO Use Rails query syntax
  #TODO Improve the query it self
  #TODO Need text so badly
  def valid_and_ordered_by_last_less_subscriptions
    Subscription.find_by_sql(
      "SELECT  `subscriptions`.*,DATE_ADD(`subscriptions`.created_at, INTERVAL `packages`.validity DAY) as end_date
    FROM  `subscriptions` 
    INNER JOIN `packages` ON `packages`.`id` = `subscriptions`.`package_id`
    WHERE DATE_ADD(`subscriptions`.created_at, INTERVAL `packages`.validity DAY) >= '#{Time.zone.now}'
    AND `subscriptions`.`user_id` = #{id}
    ORDER BY end_date;")
  end

  # Returns the number of sent messages by this user for today
  def sent_messages_for_today
    recipients.where('messages.created_at >= ? ', Date.today.beginning_of_day).count
  end

  # Returns the number of sent messages by this user for valid subscriptions only
  #TODO Could done by SQL only to be more faster
  #TODO make unit test for this function
  #TODO Need text so badly
  # Algorithm
  # - bring valid subscriptions
  # - bring the messages for each subscriptions through user
  # - count the number of recipient of each message and multiplex it with same message unit
  # - return the total.
  # could be like valid_and_ordered_by_last_less_subscriptions.each {|s| s.messages.uniq.each {|m| p m.recipients.count * m.unit}}
  def sent_messages_count
    number_of_messages = 0
    valid_and_ordered_by_last_less_subscriptions.each do |subscription|
      subscription.messages.each do |message|
        number_of_messages += message.recipients.count * message.unit
      end
    end
    return number_of_messages
  end

  # Returns the fixed Day limit, this function add all day limits for this user
  # subscriptions
  #TODO don't count the expired subscriptions
  def day_limit
    packages.map(&:day_limit).sum
  end

  # Returns total amount limit for this user
  def amount_limit
    #TODO it must be only the valid (unexpired) subscriptions for this user
    packages.map(&:amount).sum - sent_messages_count
  end

  # Returns the final limit for today by counting sent messages for today
  def today_limit
    day_limit - sent_messages_for_today
  end
  
end
