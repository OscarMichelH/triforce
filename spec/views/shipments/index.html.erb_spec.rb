require 'rails_helper'

RSpec.describe "shipments/index", type: :view do
  before(:each) do
    assign(:shipments, [
      Shipment.create!(
        name: "Name",
        email: "Email",
        phone_number: "Phone Number",
        address: "Address",
        city: "City",
        zipcode: 2,
        country: "Country",
        track_number: "Track Number",
        status: "Status",
        method: "Method",
        payment_id: "Payment",
        payment_type: "Payment Type",
        collection_id: "Collection",
        collection_status: "Collection Status",
        preference_id: "Preference",
        merchant_order_id: "Merchant Order",
        cart: nil
      ),
      Shipment.create!(
        name: "Name",
        email: "Email",
        phone_number: "Phone Number",
        address: "Address",
        city: "City",
        zipcode: 2,
        country: "Country",
        track_number: "Track Number",
        status: "Status",
        method: "Method",
        payment_id: "Payment",
        payment_type: "Payment Type",
        collection_id: "Collection",
        collection_status: "Collection Status",
        preference_id: "Preference",
        merchant_order_id: "Merchant Order",
        cart: nil
      )
    ])
  end

  it "renders a list of shipments" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new("Name".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Email".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Phone Number".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Address".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("City".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Country".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Track Number".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Status".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Method".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Payment".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Payment Type".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Collection".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Collection Status".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Preference".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Merchant Order".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
  end
end
