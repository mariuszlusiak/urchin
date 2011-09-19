require 'spec_helper'
describe Message do



  setup do

  end

  context "Associations" do
    it { should belong_to(:user) }
    it { should have_many(:recipients) }
  end

  #context "Validation" do
  #  it "can make a Person from Factory" do
  #    p = Factory(:user)
  #    p.should_not be_nil
  #    p.should be_kind_of(User)
  #  end
  #
  #  it "creates a new instance given valid attributes" do
  #    lambda {
  #      User.create(Factory.attributes_for(:user))
  #    }.should change { User.count }.by(1)
  #  end
  #
  #
  #  subject { @empty_user = User.new }
  #
  #  %w(name login email sender password).each do |field|
  #    it "should have #{field} field" do
  #      should respond_to(field)
  #    end
  #  end
  #
  #  %w(name login email sender password).each do |attr|
  #    it "must have a #{attr}. (#{attr} should not be blank)." do
  #      should_not be_valid
  #      @empty_user.errors[attr].should_not be_blank
  #    end
  #  end
  #
  #end

end