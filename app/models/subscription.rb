class Subscription < ActiveRecord::Base
  belongs_to :package
  belongs_to :user
  #TODO add status and expiry date

  validates :package, presence:true
  validates :package, presence:true
end
