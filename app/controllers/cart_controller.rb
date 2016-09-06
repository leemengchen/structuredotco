class CartController < ApplicationController
  respond_to :js
  before_action :authenticate_user!
  before_action :load_cart
  after_action :write_cart, only: [:add_item, :remove_item, :update_item]

  def show
    @items = []
    @total_price = 0.0;

    @cart.each do |k,v|
      item = Item.find_by(id: k)

      if !Item.find_by(id: k)
        flash[:danger] = "Your item is not valid!"
        break
      end

        total_item_price = 0
        total_item_price = item.price * v.to_f
        @total_price += total_item_price

        item.define_singleton_method(:quantity) {v}
        item.define_singleton_method(:total) {total_item_price}
        @items << item

    end


    rescue => e
      redirect_to items_path
      flash[:danger] = "Your cart is empty!"
  end


  def add_item
    if @cart[params[:id]]
      quantity = params[:quantity].to_i
      quantityOld = @cart[params[:id]].to_i
      @cart[params[:id]] = quantityOld + quantity
      flash.now[:success] = "You've added item to cart."
    else
      @cart[params[:id]] = params[:quantity]
    end
      # cookies[:cart] = JSON.generate(@cart)
  end



  def update_item
    if @cart[params[:id]]
      @cart[params[:id]] = params[:quantity]
    end
      redirect_to cart_show_path
      flash[:success] = "You've updated your cart."
  end

  def remove_item
      @cart.delete params[:id]
      redirect_to cart_show_path
      flash[:danger] = "Item removed!"
  end

  def load_cart
    if cookies[:cart]
      @cart = JSON.parse(cookies[:cart])
    else
      @cart = {}
    end
  end

  def write_cart
    cookies[:cart] = JSON.generate(@cart)
  end



end
