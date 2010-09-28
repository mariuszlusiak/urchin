class Recipient < ActiveRecord::Base
  belongs_to :message
end
