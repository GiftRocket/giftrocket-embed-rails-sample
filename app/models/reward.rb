class Reward < ActiveRecord::Base
  enum status: [:redeemable, :redeemed]

  belongs_to :user
  belongs_to :catalog_product
  has_many :reward_payouts

  before_create :set_defaults
  before_create :generate_public_token

  def reset_to_redeemable!
    redeemable!
    # Communicate to the user that they should attempt to
    # redeem their reward again.
  end

  def payout
    reward_payouts.order("created_at DESC").first
  end

  protected
    def set_defaults
      self.status = Reward.statuses[:redeemable]
    end

    def generate_public_token
      self.public_token = loop do
        random_token = SecureRandom.urlsafe_base64(nil, false)
        break random_token unless Reward.exists?(public_token: random_token)
      end
    end
end
