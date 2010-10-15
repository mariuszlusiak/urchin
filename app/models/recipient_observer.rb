class RecipientObserver < ActiveRecord::Observer

  # Choose a subscription for this recipient by the oldest, so customers won't kill me :D
  #TODO get not oldest subscriptions but nearest subscriptions to expired
  def before_create(recipient)
    recipient.message.user.last_less_subscriptions.each do |subscription|
      if subscription.today_limit > 0 and subscription.amount_limit > 0
        recipient.subscription_id = subscription.id
        break
      end
    end
  end
end
