module CartHelper

  def carts_hash
    return {} unless cookies[:cart]

    cart =  JSON.parse(cookies[:cart])
    total_price = 0
    items = []

    cart.each do |item_id, quantity|
      item = getCartItemFromId item_id, quantity
      if !item
        next
      end
      total_price += item.total
      items << item
    end

    { total_price: total_price, items: items }
  end

  def getCartItemFromId(id, quantity)
    item = Item.find_by(id: id)

    if !item
      return
    end

    item.define_singleton_method(:quantity) { quantity }
    item.define_singleton_method(:total) { item.price * quantity.to_f }

    return item
  end
end
