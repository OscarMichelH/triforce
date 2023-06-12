require 'rails_helper'

RSpec.describe "discounts/new", type: :view do
  before(:each) do
    assign(:discount, Discount.new(
      percentage: 1.5,
      direct: 1.5,
      quantity: 1.5,
      pieces: 1,
      type: "",
      item: nil
    ))
  end

  it "renders new discount form" do
    render

    assert_select "form[action=?][method=?]", discounts_path, "post" do

      assert_select "input[name=?]", "discount[percentage]"

      assert_select "input[name=?]", "discount[direct]"

      assert_select "input[name=?]", "discount[quantity]"

      assert_select "input[name=?]", "discount[pieces]"

      assert_select "input[name=?]", "discount[type]"

      assert_select "input[name=?]", "discount[item_id]"
    end
  end
end
