class RewardPayout < ActiveRecord::Base
  serialize :data, Hash
  # We can map status to the enum below.  For more future flexibility,
  # we can also just leave it as string as we have in this sample app.
  # enum status: [:unexecuted, :executing, :completed, :failed, :canceled]

  belongs_to :reward
  belongs_to :catalog_product

  def cancel!
    update_attributes({status: "CANCELED"})
    reward.reset_to_redeemable!
  end

  def fail!
    update_attributes({status: "FAILED"})
    reward.reset_to_redeemable!
  end
end
