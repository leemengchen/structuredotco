class OrdersController < ApplicationController
  before_action :authenticate_user!

  def new
    # form url routes to braintree
    @total_price = 0.0
    if cookies[:cart] != nil  
      @ordertotes = JSON.parse(cookies[:cart])
      @ordertotes.each do |k,v|
        item = Item.find(k)
        item_total = 0
        item_total = item.price * v.to_f
        @total_price += item_total
      end
    end

    if @total_price == 0
      flash[:danger] = "Your cart is empty!"
      redirect_to items_path
    end

    @token = Braintree::ClientToken.generate
  end

  def billplz
    @total_price = 0.0
    if cookies[:cart] != nil
      @ordertotes = JSON.parse(cookies[:cart])
      @ordertotes.each do |k,v|
        item = Item.find(k)
        item_total = 0
        item_total = item.price * v.to_f
        @total_price += item_total
      end
    end


    @order = Order.create(total_price: @total_price, user_id: current_user.id)

    if @total_price == 0
      flash[:danger] = "Your cart is empty!"
      redirect_to items_path

    elsif @order.save && @ordertotes != nil
      @bill = Billplz.create_bill_for(@order)
      @order.update_attributes(bill_id: @bill.parsed_response['id'], bill_url: @bill.parsed_response['url'])

      redirect_to @bill.parsed_response['url']
    end
  end

  def braintree
    @total_price = 0.0
    if cookies[:cart] != nil
      @ordertotes = JSON.parse(cookies[:cart])
      @ordertotes.each do |k,v|
        item = Item.find(k)
        item_total = 0
        item_total = item.price * v.to_f
        @total_price += item_total
      end
    end

    result = Braintree::Transaction.sale(
    amount: @total_price,
    payment_method_nonce: params[:payment_method_nonce],
    options: {
      submit_for_settlement: true
      }
    )

    if result.success?
      order = Order.create do
        transaction_id = result.transaction.id
        amount = result.transaction.amount
        user_id = current_user&.id
        status = "pending"
      end

      # @items.each { |item| order.ordered_items.create(item_id: item.id)}
      cookies.delete(:cart)

      flash[:success] = "We've received payment for your order. We'll ship shortly!!!"
      redirect_to root_path
    else
      flash[:danger] = "Fuck you"
      redirect_to items_path
    end
  end



  # def billplz
  #   def new
  #     @order = Order.new
  #   end
  #
  #   def create
  #     @total_price = 0.0
  #     @ordertotes = JSON.parse(cookies[:cart])
  #     @ordertotes.each do |k,v|
  #       item = Item.find(k)
  #       item_total = 0
  #       item_total = item.price * v.to_f
  #       @total_price += item_total
  #     end
  #
  #     @order = Order.create(total_price: @total_price, user_id: current_user.id)
  #     if @order.save
  #       @bill = Billplz.create_bill_for(@order)
  #       @order.update_attributes(bill_id: @bill.parsed_response['id'], bill_url: @bill.parsed_response['url'])
  #
  #       redirect_to @bill.parsed_response['url']
  #     else
  #       render :new
  #     end
  #   end
  # end

  # case params[:payment_mode]
  # when "billplz"
  #   billplz
  # when "braintree"
  #   braintree
  # end
end
