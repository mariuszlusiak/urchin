require 'spec_helper'

describe Package do
  context "Associations" do
    it { should have_many(:subscriptions) }
    it { should have_many(:packages).through(:subscriptions) }
  end
end