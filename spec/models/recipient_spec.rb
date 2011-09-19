require 'spec_helper'

describe Recipient do
  context "Associations" do
    it { should belong_to(:message) }
    it { should belong_to(:subscription) }
  end
end