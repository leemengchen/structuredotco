class CartController < ApplicationController
  respond_to :js

  def show
    items = JSON.parse(cookies[:cart])
    @total_price = 0.0;


    @items = []
    items.each do |k,v|
      total_item_price = 0.0;
      item = Item.find_by(id: k)
      if !Item.find_by(id: k)
        flash[:danger] = "Your item is not valid!"
        break
      end

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
    # if !cookies[:cart]
      # items = { params[:id] => params[:quantity] }
      # quantity = params[:quantity].to_i
      # quantityOld = cart[params[:id]].to_i
      # items[params[:id]] = quantityOld + quantity
      if !cookies[:cart]
        items = { params[:id] => params[:quantity] }
      else
    # if cookies[:cart]
        items = JSON.parse(cookies[:cart])
        items[params[:id]] = params[:quantity]
    #   else
    #     @cart = {}
    # end
      end
      cookies[:cart] = JSON.generate(items)

    # if @cart[params[:id]]
    #   quantity = params[:quantity].to_i
    #   quantityOld = @cart[params[:id]].to_i
    #   @cart[params[:id]] = quantityOld + quantity
    #   flash.now[:success] = "You've added item to cart."
    #
    # else
    #   @cart[params[:id]] = params[:quantity]
    # end
    #   cookies[:cart] = JSON.generate(@cart)
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
      flash[:success] = "You've updated your cart."

  end

  def remove_item
      items = JSON.parse(cookies[:cart])
      items.delete(params[:id])
      cookies[:cart] = JSON.generate(items)
      redirect_to cart_show_path
      flash[:danger] = "Item removed!"

  end



end
