require 'test_helper'

class RecipientTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end
# == Schema Information
#
# Table name: recipients
#
#  id              :integer(4)      not null, primary key
#  mobile_number   :string(255)     not null
#  response        :string(255)
#  message_id      :integer(4)      not null
#  subscription_id :integer(4)      not null
#  sent_at         :datetime
#  received_at     :datetime
#  created_at      :datetime
#  updated_at      :datetime
#

