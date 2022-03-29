








# TODO: maybe add one for :has_and_belongs_to_many?
# TODO: Implement insertions for existing files... why??

require 'rails_helper'

RSpec.describe Book, type: :model do
  it "should have a valid factory" do
    book = FactoryBot.build(:book)
    expect(book).to be_valid
  end

  describe "Validators" do

  	
  		
  			it "should ensure the presence of user" do
  				book = FactoryBot.build(:book, user: nil)
  				expect(book).not_to be_valid
  				expect(book.errors[:user]).to be_present
  			end
  		
  	

  	
  end

  

	  describe "Associations" do
	  	
	  		it "should belong to a user" do
	  			user = FactoryBot.create(:user)
	  			book = FactoryBot.build(:book, user: user)
	  			expect(book.user).to eq user
	  		end
	  	

	  	
	  		it "should allow multiple sales" do
	  			book = FactoryBot.create(:book)

	  			3.times.each do |n|
	  				sale = FactoryBot.create(:sale)
	  				book.sales << sale
	  				book_sales = book.sales
	  				expect(book_sales.count).to eq n.next
	  				expect(book_sales).to include sale
	  			end
	  		end

	  	
	  end
	

	
		describe "Graceful Destroyal" do
			

			
				
				it "should destroy the associated sales when deleted" do
					book = FactoryBot.create(:book)
					book.sales.create(FactoryBot.attributes_for(:sale))

					expect{ book.destroy }.to change(Sale, :count).by -1
				end
			
		end
end
