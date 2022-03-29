








# TODO: maybe add one for :has_and_belongs_to_many?
# TODO: Implement insertions for existing files... why??

require 'rails_helper'

RSpec.describe Cart, type: :model do
  it "should have a valid factory" do
    cart = FactoryBot.build(:cart)
    expect(cart).to be_valid
  end

  describe "Validators" do

  	
  		
  			it "should ensure the presence of user" do
  				cart = FactoryBot.build(:cart, user: nil)
  				expect(cart).not_to be_valid
  				expect(cart.errors[:user]).to be_present
  			end
  		
  	

  	
  end

  

	  describe "Associations" do
	  	
	  		it "should belong to a user" do
	  			user = FactoryBot.create(:user)
	  			cart = FactoryBot.build(:cart, user: user)
	  			expect(cart.user).to eq user
	  		end
	  	

	  	
	  end
end
