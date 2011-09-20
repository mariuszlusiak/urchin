require 'spec_helper'

describe Package do
  context "Associations" do
    it { should have_many(:subscriptions) }
    it { should have_many(:packages).through(:subscriptions) }
  end
end# == Schema Information
#
# Table name: packages
#
#  id          :integer(4)      not null, primary key
#  name        :string(255)
#  description :text
#  day_limit   :integer(4)
#  amount      :integer(4)
#  validity    :integer(4)
#  created_at  :datetime
#  updated_at  :datetime
#

