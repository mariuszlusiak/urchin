class RecipientObserver < ActiveRecord::Observer

  def before_create(recipient)

    #ISSUE Very Bad, I need to use scope  
    # Choose a subscription for this recipient by the oldest, so customers won't kill me :D
    recipient.message.user.valid_and_ordered_by_last_less_subscriptions.each do |subscription|
      if subscription.today_limit > 0 and subscription.amount_limit > 0
        recipient.subscription_id = subscription.id
        break
      end
    end

  end

end
