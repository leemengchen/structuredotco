class CartController < ApplicationController
  respond_to :js

  def show
    items = JSON.parse(cookies[:cart])

    @items = []
    items.each do |k,v|
      item = Item.find_by(id: k)
      item.define_singleton_method(:quantity) do
        v
      end
      @items << item
    end
  end

  def add_item
    # if !cookies[:cart]
      # items = { params[:id] => params[:quantity] }
      # quantity = params[:quantity].to_i
      # quantityOld = cart[params[:id]].to_i
      # items[params[:id]] = quantityOld + quantity  


    # if cookies[:cart]
      @cart = JSON.parse(cookies[:cart])
    #   else
    #     @cart = {}
    # end

    if @cart[params[:id]]
      quantity = params[:quantity].to_i
      quantityOld = @cart[params[:id]].to_i
      @cart[params[:id]] = quantityOld + quantity
      flash.now[:success] = "You've added item to cart."
 
    else
      @cart[params[:id]] = params[:quantity]
    end
      cookies[:cart] = JSON.generate(@cart)
  end

  def update_item
    if !cookies[:cart]
      items = { params[:id] => params[:quantity] }
    else
      items = JSON.parse(cookies[:cart])
      items[params[:id]] = params[:quantity]
    end
      cookies[:cart] = JSON.generate(items)
      redirect_to cart_show_path
      flash.now[:success] = "You've updated your cart."

  end

  def remove_item
      items = JSON.parse(cookies[:cart])
      items.delete(params[:id])
      cookies[:cart] = JSON.generate(items)
      redirect_to cart_show_path
      flash.now[:danger] = "Item removed!"

  end
  
end
