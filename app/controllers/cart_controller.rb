class CartController < ApplicationController
  respond_to :js

  def show
    items = JSON.parse(cookies[:cart])

    @items = []
    items.each do |k,v|
      # your k is your item id
      # your v is your quantity
      # you can also rename k to item_id, and v to quantity for clarity
      # search for your item
      item = Item.find_by(id: k)

      # creates a new method and assigns the quantity to it
      def item.quantity
        v
      end
      @items << item
    end
  end

  def add_item
    if !cookies[:cart]
      items = { params[:id] => params[:quantity] }
    else
      items = JSON.parse(cookies[:cart])
      items[params[:id]] = params[:quantity]
    end

      cookies[:cart] = JSON.generate(items)
  end

  def update_item
  end

  def remove_item
    if !cookies[:cart] #checks if an existing cart exists
      items = { params[:id] => params[:quantity] }
    else
      items = JSON.parse(cookies[:cart])
      items[params[:id]] = params[:quantity]
    end

    cookies[:cart] = JSON.generate(items)
  end
  
end
