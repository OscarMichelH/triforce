require 'rails_helper'

RSpec.describe "discounts/index", type: :view do
  before(:each) do
    assign(:discounts, [
      Discount.create!(
        percentage: 2.5,
        direct: 3.5,
        quantity: 4.5,
        pieces: 5,
        type: "Type",
        item: nil
      ),
      Discount.create!(
        percentage: 2.5,
        direct: 3.5,
        quantity: 4.5,
        pieces: 5,
        type: "Type",
        item: nil
      )
    ])
  end

  it "renders a list of discounts" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new(2.5.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(3.5.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(4.5.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(5.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Type".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
  end
end
