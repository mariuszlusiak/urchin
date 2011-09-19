require 'test_helper'

class PackageTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end
# == Schema Information
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

