require 'spec_helper'

describe Subscription do
  context "Associations" do
    it { should belong_to(:package) }
    it { should belong_to(:user) }
    it { should have_many(:messages).through(:user) }
  end

  it "when new subscription should add new package day_limit value to user daily_limit" do
    p = packages(:package_001)
    u = users(:user_001)
    old_daily_limit = u.daily_limit
    s = Subscription.new
    s.package_id = p.id
    s.user_id = u.id
    s.save
    u.reload
    u.daily_limit.should == old_daily_limit + p.day_limit
  end

  it "when new subscription should add new package validity value to user validity" do
    p = packages(:package_001)
    u = users(:user_001)
    old_validity = u.validity
    s = Subscription.new
    s.package_id = p.id
    s.user_id = u.id
    s.save
    u.reload
    u.validity.should == old_validity + p.validity
  end

  it "when new subscription should add new package amount value to user units" do
    p = packages(:package_001)
    u = users(:user_001)
    old_units = u.units
    s = Subscription.new
    s.package_id = p.id
    s.user_id = u.id
    s.save
    u.reload
    u.units.should == old_units + p.amount
  end


end

# == Schema Information
#
# Table name: subscriptions
#
#  id         :integer(4)      not null, primary key
#  package_id :integer(4)      not null
#  user_id    :integer(4)      not null
#  created_at :datetime
#  updated_at :datetime
#

