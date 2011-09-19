class Package < ActiveRecord::Base
  has_many :subscriptions
  has_many :packages, :through => :subscriptions

  validates :name,      presence:true, uniqueness:true
  validates :day_limit, presence:true
  validates :amount,    presence:true
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

