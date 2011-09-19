require 'spec_helper'
  #belongs_to :package
  #belongs_to :user
  #has_many :recipients
  #has_many :messages ,:through => :user


describe Subscription do
  context "Associations" do
    it { should belong_to(:package) }
    it { should belong_to(:user) }
    it { should have_many(:recipients) }
    it { should have_many(:messages).through(:user) }
  end
end