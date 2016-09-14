class Billplz
  def self.create_bill_for(order)
    HTTParty.post("https://www.billplz.com/api/v3/bills".to_str,
    headers: {'Content-Type' => 'application/json', 'Accept' => 'application/json'},
    body: {
      collection_id:        "qobdfigt1",
      email:                order.user.email,
      name:                 "Karl Weezer",
      amount:               order.total_price * 100,
      callback_url:         "http://localhost:3000/webhooks/payment_callback",
      description:          "Structure.co: shop like yo mom homie! Like there's no tomorrow.",
      due_at:               order.due_at,
      redirect_url:         "http://localhost:3000/orders/#{order.id}",
      deliver:              "false",
      reference_1_label:    "Order Booking Ref",
      reference_1_:         order.id
    }.to_json,
    basic_auth: { username: "bfad0def-ab35-42f4-b0e7-1ac130c74860:" }
    )
  end

  def self.check_status(order_id)
    order = order.find(order_id)
    url = "https://www.billplz.com/api/v3/bills/" + order.bill_id
    arguments = { headers: {'Content-Type' => 'application/json', 'Accept' => 'application/json'},
                basic_auth: { username: "bfad0def-ab35-42f4-b0e7-1ac130c74860:" }
              }
    HTTParty.get(url, arguments)
  end
end
