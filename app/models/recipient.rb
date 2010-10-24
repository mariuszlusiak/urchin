class Recipient < ActiveRecord::Base
  belongs_to :message
  belongs_to :user
  belongs_to :subscription

  # This Validation is already exist in Message Model under the method :valid_mobile_numbers?
  # I choose to stope this validation rather than Message Model validation
  # to prevent double check and to have better Error message for Invalid Mobile number
  # validates :mobile_number, :numericality => true, :presence => true

end
