require 'rails_helper'

RSpec.describe Item, type: :model do
  it "should have a valid factory" do
    item = FactoryBot.build(:item)
    expect(item).to be_valid
  end

  describe "Validators" do

  	
  		
  			it "should ensure the presence of user" do
  				item = FactoryBot.build(:item, user: nil)
  				expect(item).not_to be_valid
  				expect(item.errors[:user]).to be_present
  			end
  		
  	

  	
  end

  

	  describe "Associations" do
	  	
	  		it "should belong to a user" do
	  			user = FactoryBot.build(:user)
	  			item = FactoryBot.build(:item, user: user)
	  			expect(item.user).to eq user
	  		end
	  	

	  	
	  		it "should allow multiple sales" do
	  			item = FactoryBot.create(:item)

	  			3.times.each do |n|
	  				sale = FactoryBot.create(:sale)
	  				item.sales << sale
	  				item_sales = item.sales
	  				expect(item_sales.count).to eq n.next
	  				expect(item_sales).to include sale
	  			end
	  		end

	  	
	  end
	

	
		describe "Graceful Destroyal" do




				it "should destroy the associated sales when deleted" do
					item = FactoryBot.create(:item)
					item.sales.create(FactoryBot.attributes_for(:sale))

					expect{ item.destroy }.to change(Sale, :count).by -1
				end

		end
end
