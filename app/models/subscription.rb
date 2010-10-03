class Subscription < ActiveRecord::Base
  belongs_to :package
  belongs_to :user

  validates :package, presence:true
  validates :package, presence:true
end
