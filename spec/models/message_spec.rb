# encoding: UTF-8
require 'spec_helper'
describe Message do

  context "Associations" do
    it { should belong_to(:user) }
    it { should have_many(:recipients) }
  end
  unless ENV['TRAVIS']

    context "Sending message" do
      it "should send message" do
        f = "#{Rails.root}/log/message.log"
        sent_messages_number = %x[wc -l < #{f}].to_i
        m = messages(:message_001)
        Sms.new(m)
        sleep (5.seconds)
        new_sent_messages_number = %x[wc -l < #{f}].to_i - m.recipients.count
        new_sent_messages_number.should == sent_messages_number
      end
    end
  end

  context "Validation" do

  end


  context "Methods" do


    subject { @message = Message.new(:text => 'Acii Text.1234567890Zz?></""{}#$%^&!') }

    it "this text is ascii, is_ascii should return true" do
      should be_is_ascii
    end

    it "this text is ascii, is_ascii should return true" do
      Message.new(:text => 'ليس أسكي').should_not be_is_ascii

    end

    it "should set sender" do
      m = messages(:message_001)
      m.set_sender
      m.sender.should == m.user.sender
    end

    it "should set unit" do
      m = messages(:message_003)
      m.unit = 0
      m.set_unit
      m.unit.should == 2
    end

    #it "when user daily limit 0" do
    #  u = users(:user_001)
    #  u.update_attribute(:daily_limit, 0)
    #  m = u.messages[0]
    #  m.user_daily_limit.should be_false
    #end
    #
    #it "when user daily limit less than needed units" do
    #  u = users(:user_001)
    #  u.update_attribute(:daily_limit, 7)
    #  m = u.messages[0]
    #  m.needed_units.should == 8
    #  m.user_daily_limit.should be_false
    #  end
    #
    #it "when user daily limit more  eq  units" do
    #  u = users(:user_001)
    #  u.update_attribute(:daily_limit, 8)
    #  m = u.messages[0]
    #  m.needed_units.should == 8
    #  m.user_daily_limit.should be_true
    #end
  end

end

# == Schema Information
#
# Table name: messages
#
#  id         :integer(4)      not null, primary key
#  text       :string(255)
#  sender     :string(255)     not null
#  ascii      :boolean(1)
#  unit       :integer(4)      not null
#  user_id    :integer(4)      not null
#  created_at :datetime

#  updated_at :datetime
#

