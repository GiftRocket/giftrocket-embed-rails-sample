class HomeController < ApplicationController
  def index
    @rewards = Reward.redeemed
  end
end
