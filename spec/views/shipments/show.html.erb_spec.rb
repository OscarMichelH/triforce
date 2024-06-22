require 'rails_helper'

RSpec.describe "shipments/show", type: :view do
  before(:each) do
    assign(:shipment, Shipment.create!(
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
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/Phone Number/)
    expect(rendered).to match(/Address/)
    expect(rendered).to match(/City/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Country/)
    expect(rendered).to match(/Track Number/)
    expect(rendered).to match(/Status/)
    expect(rendered).to match(/Method/)
    expect(rendered).to match(/Payment/)
    expect(rendered).to match(/Payment Type/)
    expect(rendered).to match(/Collection/)
    expect(rendered).to match(/Collection Status/)
    expect(rendered).to match(/Preference/)
    expect(rendered).to match(/Merchant Order/)
    expect(rendered).to match(//)
  end
end
