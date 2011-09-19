require 'spec_helper'

describe User do


  before do

  end


  context "Associations" do
    it { should have_many(:messages) }
    it { should have_many(:recipients).through(:messages) }

    it { should have_many(:subscriptions) }
    it { should have_many(:packages).through(:subscriptions) }
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

    %w(name login email sender password).each do |field|
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


  #it "should not create a person without last name" do
  #  p = Person.create(@no_last_name)
  #  p.valid?
  #  p.errors[:last_name].should_not be_nil
  #end

  #
  #it "should not create a person with empty first name" do
  #  p = Person.new(:first_name => '',:last_name => 'Janas')
  #  p.first_name.should be_blank
  #  p.should_not be_valid
  #  p.errors[:first_name].should_not be_blank
  #end
  #
  #
  #describe "Associations" do
  #  subject { Factory(:person) }
  #  it { should respond_to :messages }
  #  it { should respond_to :addresses }
  #
  #
  #  it "can retrieve a massage" do
  #    m = Factory(:message)
  #    p = m.recipient
  #    p.messages.should == [m]
  #  end
  #
  #end
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
#  created_at          :datetime
#  updated_at          :datetime
#

#describe Message do
#  describe "Validations" do
#    before do
#      @m = Message.new
#      @m.should_not be_valid
#    end
#
#    %w(sender recipient subject).each do |attr|
#      it "must have #{attr}" do
#        @m.errors[attr].should_not be_nil
#      end
#
#    end
#  end
#
#  describe "Associations" do
#    it "must belongs to sender" do
#      Message.new.should respond_to(:sender)
#      end
#
#    it "must belongs to recipient" do
#      Message.new.should respond_to(:recipient)
#    end
#
#    it "can retrieve a sender and that is a Person object" do
#      msg = Factory(:message)
#      msg.sender.should_not be_nil
#      msg.sender.should be_kind_of(Person)
#
#    end
#
#  end
#end
#describe Address do
#  before do
#
#
#    @person = Person.create!(
#        {
#            :first_name => "Samer",
#            :last_name => "Jazaerly"
#        }
#    )
#
#
#    @address_without_country ={
#        :street => "street name",
#        :city => "City Name",
#        :zip => "123456",
#        :person_id => @person.id
#    }
#
#  end
#
#
#  subject { Factory(:address) }
#
#  [:street, :city, :zip, :person_id, :state].each do |field|
#    it "should have #{field} field" do
#      should respond_to(field)
#    end
#  end
#
#  it "when state is 2-letter" do
#    subject.state = "CA"
#    should be_valid
#  end
#
#  it "when state is more than 2" do
#    subject.state = "CACA"
#    should_not be_valid
#  end
#
#  it "when state is blank" do
#    subject.state = ''
#    subject.should be_valid
#  end
#
#  it "when state is less than 2" do
#    subject.state = 'C'
#    should_not be_valid
#  end
#
#  it "when country is USA and state is empty" do
#    subject.country = "USA"
#    subject.state = ''
#    should_not be_valid
#  end
#
#  it "when country is not USA and state is empty" do
#    subject.country = "syria"
#    subject.state = ''
#    should be_valid
#  end
#
#
#
#
#
#
#  context "Validations" do
#
#
#    it "must create new address" do
#      lambda {
#        (Factory(:address)).save
#      }.should change { Address.count }.by(1)
#    end
#
#    [:street, :city, :zip].each do |attr|
#      it "must have a #{attr}" do
#        a = Address.new
#        a.should_not be_valid
#        a.errors[attr].should_not be_blank
#      end
#    end
#
#    it "must set default country 'Syria' if the country is missing" do
#      a = Factory(:address)
#      a.country = ''
#      a.country.should be_blank
#      a.save!
#      a.country.should == 'Syria'
#    end
#
#
#  end
#
#end
