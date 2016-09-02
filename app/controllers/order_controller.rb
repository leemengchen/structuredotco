class OrderController < ApplicationController

  def new
    @client_token = Braintree::ClientToken.generate
  end

  def show
  end

end
