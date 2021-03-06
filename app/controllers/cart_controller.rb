class CartController < ApplicationController
  respond_to :js
  # before_action :authenticate_user!
  before_action :load_cart
  # after_action :write_cart, only: [:remove_item, :update_item]

  include CartHelper

  def add_item
    if @cart[params[:id]]
      quantity = params[:quantity].to_i
      quantityOld = @cart[params[:id]].to_i
      @cart[params[:id]] = quantityOld + quantity
    else
      @cart[params[:id]] = params[:quantity]
    end
    flash.now[:success] = "You've added item to cart."
    cookies[:cart] = JSON.generate(@cart)
  end

  def update_item
    if @cart[params[:id]]
      @cart[params[:id]] = params[:quantity]
    end
    cookies[:cart] = JSON.generate(@cart)
    @update_item = getCartItemFromId params[:id], params[:quantity]
    flash.now[:success] = "You've updated your cart."
  end

  def remove_item
    @cart.delete params[:id]
    flash.now[:danger] = "Item removed!"
    cookies[:cart] = JSON.generate(@cart)
    @deletable_item = params[:id]
  end

  def load_cart
    if cookies[:cart]
      @cart = JSON.parse(cookies[:cart])
    else
      @cart = {}
    end
  end

  # def write_cart
  #   cookies[:cart] = JSON.generate(@cart)
  # end


end
