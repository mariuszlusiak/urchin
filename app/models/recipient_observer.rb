class RecipientObserver < ActiveRecord::Observer

  # Choose a subscription for this recipient by the oldest, so customers won't kill me :D
  #TODO get not oldest subscriptions but nearest subscriptions to expired
  def before_save(recipient)
    recipient.message.user.subscriptions.order('created_at DESC').each do |subscription|
      if subscription.today_limit > 0 and subscription.amount_limit > 0
        recipient.subscription_id = subscription.id
      end
    end
  end
end
