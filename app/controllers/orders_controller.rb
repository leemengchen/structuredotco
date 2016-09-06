class OrdersController < ApplicationController

  def new
    @order = Order.new
  end

  def create
    @total_price = 0.0
    @ordertotes = JSON.parse(cookies[:cart])
    @ordertotes.each do |k,v|
      item = Item.find(k)
      item_total = 0
      item_total = item.price * v.to_f
      @total_price += item_total
  end

    @order = Order.create(total_price: @total_price, user_id: current_user.id)
    if @order.save
      @bill = Billplz.create_bill_for(@order)
      @order.update_attributes(bill_id: @bill.parsed_response['id'], bill_url: @bill.parsed_response['url'])
 
      redirect_to @bill.parsed_response['url']
    else
      render :new
    end
  end

  # private
  #   def order_params
  #     params.require(:order).permit(:user_id, :status, :total, :bill_id, :bill_url, :due_at, :paid_at)
  #   end
  end
