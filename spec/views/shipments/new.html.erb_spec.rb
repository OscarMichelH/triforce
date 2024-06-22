require 'rails_helper'

RSpec.describe "shipments/new", type: :view do
  before(:each) do
    assign(:shipment, Shipment.new(
      name: "MyString",
      email: "MyString",
      phone_number: "MyString",
      address: "MyString",
      city: "MyString",
      zipcode: 1,
      country: "MyString",
      track_number: "MyString",
      status: "MyString",
      method: "MyString",
      payment_id: "MyString",
      payment_type: "MyString",
      collection_id: "MyString",
      collection_status: "MyString",
      preference_id: "MyString",
      merchant_order_id: "MyString",
      cart: nil
    ))
  end

  it "renders new shipment form" do
    render

    assert_select "form[action=?][method=?]", shipments_path, "post" do

      assert_select "input[name=?]", "shipment[name]"

      assert_select "input[name=?]", "shipment[email]"

      assert_select "input[name=?]", "shipment[phone_number]"

      assert_select "input[name=?]", "shipment[address]"

      assert_select "input[name=?]", "shipment[city]"

      assert_select "input[name=?]", "shipment[zipcode]"

      assert_select "input[name=?]", "shipment[country]"

      assert_select "input[name=?]", "shipment[track_number]"

      assert_select "input[name=?]", "shipment[status]"

      assert_select "input[name=?]", "shipment[method]"

      assert_select "input[name=?]", "shipment[payment_id]"

      assert_select "input[name=?]", "shipment[payment_type]"

      assert_select "input[name=?]", "shipment[collection_id]"

      assert_select "input[name=?]", "shipment[collection_status]"

      assert_select "input[name=?]", "shipment[preference_id]"

      assert_select "input[name=?]", "shipment[merchant_order_id]"

      assert_select "input[name=?]", "shipment[cart_id]"
    end
  end
end
