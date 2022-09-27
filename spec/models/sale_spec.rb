require 'rails_helper'

RSpec.describe Sale, type: :model do
  it "should have a valid factory" do
    user = FactoryBot.build(:user)
    item = FactoryBot.build(:item)
    sale = FactoryBot.build(:sale, user: user, item: item)
    expect(sale).to be_valid
  end

  describe "Validators" do

  	
  		
  			it "should ensure the presence of user" do
  				sale = FactoryBot.build(:sale, user: nil)
  				expect(sale).not_to be_valid
  				expect(sale.errors[:user]).to be_present
  			end
  		
  	

  	
  end

  

	  describe "Associations" do
	  	
	  		it "should belong to a user" do
	  			user = FactoryBot.build(:user)
          item = FactoryBot.build(:item)
	  			sale = FactoryBot.build(:sale, user: user, item: item)
	  			expect(sale.user).to eq user
	  		end
	  	
	  		it "should belong to a item" do
					user = FactoryBot.build(:user)
					item = FactoryBot.build(:item)
	  			sale = FactoryBot.build(:sale, user: user, item: item)
	  			expect(sale.item).to eq item
	  		end
	  	

	  	
	  end
end
