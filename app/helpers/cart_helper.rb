module CartHelper

  def carts_hash
    return {} unless cookies[:cart]

    cart =  JSON.parse(cookies[:cart])
    total_price = 0
    items = []

    cart.each do |item_id, quantity|
      item = Item.find_by(id: item_id)

      item.define_singleton_method(:quantity) { quantity }
      item.define_singleton_method(:total) { price * quantity.to_f }
      total_price += item.price * quantity.to_f
      items << item
    end

    { total_price: total_price, items: items }
  end
end
