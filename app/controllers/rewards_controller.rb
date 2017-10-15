class RewardsController < ApplicationController

  def new
    @reward = reward = new_reward
    @catalog = CatalogProduct.all.select do |item|
      ["MERCHANT_CARDS", "VISA"].include?(item.category)
    end.map(&:giftrocket_id)
    shared_view_variables(reward)
  end

  def show
    @reward = reward = Reward.find_by_id(params[:id])
    raise ActionController::RoutingError.new('Not Found') unless reward.present?

    shared_view_variables(reward)
  end

  def update
    reward = Reward.find_by_id(params[:id])
    if reward.blank?
      logger.error("Attempt to re-redeem reward :: #{params[:id]}")
      render status: 401, json: {}
    elsif reward.redeemed?
      logger.warn("Attempt to re-redeem reward :: #{params[:id]}")
      render json: {}
    else
      logger.info("Redeem reward :: #{params[:id]}")
      reward.update_attributes({
        giftrocket_id: params[:giftrocket_id],
        status: Reward.statuses[:redeemed]
      })

      begin
        gift = Giftrocket::Gift.retrieve(reward.giftrocket_id)
        # Payouts returned in descending chronological order
        payout = gift.raw[:payouts].first

        RewardPayout.create!({
          reward: reward,
          created_at: DateTime.strptime("#{payout[:created_at]}",'%s'),
          giftrocket_id: payout[:id],
          status: payout[:status],
          catalog_product_id: CatalogProduct.find_by_giftrocket_id(payout[:catalog_id]).id,
          data: payout[:data]
        })

        render json: {}
      rescue => e
        logger.error("Redeem reward failed :: #{params[:id]}")
        logger.error e.message
        logger.error e.backtrace.join("\n")

        render status: 500, json: {}
      end
    end
  end

  def error
  end

  def webhook
    # TODO: handle this in an asynchronous worker if possible
    # so that we can respond to the webhook quickly.
    Webhook.handle(params)
    render status: 200, json: {}
  end

  private
    def new_reward
      # For demo purposes, we create a new reward each time we render the page.
      # This is more convenient than running a rake task to generate new model instances.
      user = User.find_or_create_by({
        name: 'Test User',
        email: "test@mydomain.com"
      })

      Reward.create!({
        user: user,
        amount: (params[:amount].presence || 50).to_i
      })
    end

    def require_reward
      reward = Reward.find_by_id(params[:id])
      if reward.blank?
        logger.error("Attempt to re-redeem completed reward #{params[:id]}")
        render status: 404, json: {}
      end
    end

    def shared_view_variables(reward)
      @public_key = GIFTROCKET_EMBED_PUBLIC_KEY
      @token = Giftrocket::Embed.tokenize({
        amount: reward.amount,
        external_id: reward.public_token,
        recipient: {
          email: reward.user.email,
          name: reward.user.name
        },
      })
    end
end
