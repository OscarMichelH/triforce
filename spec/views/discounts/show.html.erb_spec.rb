require 'rails_helper'

RSpec.describe "discounts/show", type: :view do
  before(:each) do
    assign(:discount, Discount.create!(
      percentage: 2.5,
      direct: 3.5,
      quantity: 4.5,
      pieces: 5,
      type: "Type",
      item: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2.5/)
    expect(rendered).to match(/3.5/)
    expect(rendered).to match(/4.5/)
    expect(rendered).to match(/5/)
    expect(rendered).to match(/Type/)
    expect(rendered).to match(//)
  end
end
