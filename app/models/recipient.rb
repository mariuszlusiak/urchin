class Recipient < ActiveRecord::Base
  belongs_to :message
  belongs_to :user
  belongs_to :subscription
 
end
