








# TODO: maybe add one for :has_and_belongs_to_many?
# TODO: Implement insertions for existing files... why??

require 'rails_helper'

RSpec.describe User, type: :model do
  it "should have a valid factory" do
    user = FactoryBot.build(:user)
    expect(user).to be_valid
  end

  describe "Validators" do

  	
  		
  			it "should ensure the presence of email" do
  				user = FactoryBot.build(:user, email: nil)
  				expect(user).not_to be_valid
  				expect(user.errors[:email]).to be_present
  			end
  		
  	

  	
  		
  			
	  		
		  		it "should ensure the uniqueness of email" do
		      	user = FactoryBot.create(:user)
						
		      		new_user = FactoryBot.build(:user, email: user.email)
		      	
		      	expect(new_user).not_to be_valid
		      	expect(new_user.errors[:email]).to be_present
		    	end
		    
		  
  	
  end

  

	  describe "Associations" do
	  	

	  	
	  		it "should allow multiple books" do
	  			user = FactoryBot.create(:user)

	  			3.times.each do |n|
	  				book = FactoryBot.create(:book)
	  				user.books << book
	  				user_books = user.books
	  				expect(user_books.count).to eq n.next
	  				expect(user_books).to include book
	  			end
	  		end

	  	
	  		it "should allow multiple sales" do
	  			user = FactoryBot.create(:user)

	  			3.times.each do |n|
	  				sale = FactoryBot.create(:sale)
	  				user.sales << sale
	  				user_sales = user.sales
	  				expect(user_sales.count).to eq n.next
	  				expect(user_sales).to include sale
	  			end
	  		end

	  	
	  end
	

	
		describe "Graceful Destroyal" do
			
				
				it "should destroy the associated cart when deleted" do
					user = FactoryBot.create(:user)
					cart = FactoryBot.create(:cart)
					user.carts << cart

					expect{ user.destroy }.to change(Cart, :count).by -1
				end
			

			
				
				it "should destroy the associated books when deleted" do
					user = FactoryBot.create(:user)
					user.books.create(FactoryBot.attributes_for(:book))

					expect{ user.destroy }.to change(Book, :count).by -1
				end
			
				
				it "should destroy the associated sales when deleted" do
					user = FactoryBot.create(:user)
					user.sales.create(FactoryBot.attributes_for(:sale))

					expect{ user.destroy }.to change(Sale, :count).by -1
				end
			
		end
end
