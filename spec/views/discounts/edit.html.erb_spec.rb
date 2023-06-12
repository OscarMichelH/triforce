require 'rails_helper'

RSpec.describe "discounts/edit", type: :view do
  let(:discount) {
    Discount.create!(
      percentage: 1.5,
      direct: 1.5,
      quantity: 1.5,
      pieces: 1,
      type: "",
      item: nil
    )
  }

  before(:each) do
    assign(:discount, discount)
  end

  it "renders the edit discount form" do
    render

    assert_select "form[action=?][method=?]", discount_path(discount), "post" do

      assert_select "input[name=?]", "discount[percentage]"

      assert_select "input[name=?]", "discount[direct]"

      assert_select "input[name=?]", "discount[quantity]"

      assert_select "input[name=?]", "discount[pieces]"

      assert_select "input[name=?]", "discount[type]"

      assert_select "input[name=?]", "discount[item_id]"
    end
  end
end
