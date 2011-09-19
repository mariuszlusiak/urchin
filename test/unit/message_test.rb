require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
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

