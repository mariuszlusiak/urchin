require 'spec_helper'

describe User do


  before do

  end


  context "Fixtures" do
    it "should load users fixtures" do
      u = users(:user_001)
      u.should_not be_nil
      u.should be_kind_of(User)
    end
  end

  context "Associations" do
    it { should have_many(:messages) }
    it { should have_many(:recipients).through(:messages) }

    it { should have_many(:subscriptions) }
    it { should have_many(:packages).through(:subscriptions) }
  end

  context "Methods" do

    it "Should retrieve " do
      u = users(:user_001)
      u.packages[0].should be_kind_of(Package)
    end

    #it "should calculate today_limit for user" do
    #  u = users(:user_001)
    #  recipient_number = u.recipients.where('messages.created_at >= ? ', messages(:message_001).created_at.beginning_of_day).count
    #  today_limit = u.daily_limit - recipient_number
    #  u.today_limit.should == today_limit
    #end

    it "should give back user units" do
      u = users(:user_001)
      u.units_limit.should == u.units
    end

    it "should subtract sent units from user units" do
      u = users(:user_001)
      m = messages(:message_003)
      r = m.recipients[0]
      old_units = u.units
      u.minus_units(r)
      u.units.should == old_units - m.unit
    end

    it "should subtract sent units from user daily_limit" do
      u = users(:user_001)
      m = messages(:message_003)
      r = m.recipients[0]
      old_daily_limit = u.daily_limit
      u.minus_daily_limit(r)
      u.daily_limit.should == old_daily_limit - m.unit
    end





  end

  context "Validation" do
    it "can make a Person from Factory" do
      p = Factory(:user)
      p.should_not be_nil
      p.should be_kind_of(User)
    end

    it "creates a new instance given valid attributes" do
      lambda {
        User.create(Factory.attributes_for(:user))
      }.should change { User.count }.by(1)
    end


    subject { @empty_user = User.new }
    %w(daily_limit units validity).each do |attr|
      it "#{attr} should be 0" do
        u = User.new
        u.method(attr).call.should == 0
      end
    end

    %w(name login email sender password daily_limit units validity).each do |field|
      it "should have #{field} field" do
        should respond_to(field)
      end
    end

    %w(name login email sender password).each do |attr|
      it "must have a #{attr}. (#{attr} should not be blank)." do
        should_not be_valid
        @empty_user.errors[attr].should_not be_blank
      end
    end

  end


end
# == Schema Information
#
# Table name: users
#
#  id                  :integer(4)      not null, primary key
#  name                :string(255)     not null
#  login               :string(255)     not null
#  email               :string(255)     not null
#  sender              :string(255)     not null
#  crypted_password    :string(255)     not null
#  password_salt       :string(255)     not null
#  persistence_token   :string(255)     not null
#  single_access_token :string(255)     not null
#  perishable_token    :string(255)     not null
#  login_count         :integer(4)      default(0), not null
#  failed_login_count  :integer(4)      default(0), not null
#  last_request_at     :datetime
#  current_login_at    :datetime
#  last_login_at       :datetime
#  current_login_ip    :string(255)
#  last_login_ip       :string(255)
#  daily_limit         :integer(4)      default(0)
#  units               :integer(4)      default(0)
#  validity            :integer(4)      default(0)
#  created_at          :datetime
#  updated_at          :datetime
#