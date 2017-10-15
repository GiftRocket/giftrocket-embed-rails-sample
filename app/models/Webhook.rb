module Webhook
  def self.handle(body)
    Rails.logger.info("GiftRocket webhook fired :: #{body}")
    # Each webhook contains a event_id property.
    # Retries due to failed responses by this server will
    # contain the same event_id. We could store this value
    # and discard duplicate webhooks or we can make our code idempotent.

    case body[:event]
    when "gift.REDEEMED"
      self.on_redeemed(body[:payload])
    when "gift.PAYOUT_CANCELED"
      byebug
      self.on_payout_canceled(body[:payload])
    when "gift.PAYOUT_FAILED"
      self.on_payout_failed(body[:payload])
    when "funding.NFS"
      # Our GiftRocket account balance is insufficient.
      # We must execute a wire or ACH payment to add more funds.
      # This should notify an administrator internally.

    end
  end

  def self.on_redeemed(reward)
    reward = Reward.find_by_giftrocket_id(reward[:id])
    # We can confirm that the state of our reward is correct (:redeemed)
    # gift = Giftrocket::Gift.retrieve(payload[:id])
    # payout = gift.raw[:payouts].first
  end

  def self.on_payout_canceled(reward)
    # The user or your team initiated a cancellation of the payout
    # typically so that the recipient can select a different option.
    # Cancel the payout and communicate to the user to redeem again.
    RewardPayout.find_by_giftrocket_id(
      reward[:payout][:id]
    ).cancel!
  end

  def self.on_payout_failed(reward)
    # The recipient provided bad redemption information or the payout
    # otherwise failed. Fail the payout and communicate to the user to redeem again.
    RewardPayout.find_by_giftrocket_id(
      reward[:payout][:id]
    ).fail!
  end
end
