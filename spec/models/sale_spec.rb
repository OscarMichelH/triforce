








# TODO: maybe add one for :has_and_belongs_to_many?
# TODO: Implement insertions for existing files... why??

require 'rails_helper'

RSpec.describe Sale, type: :model do
  it "should have a valid factory" do
    sale = FactoryBot.build(:sale)
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
	  			user = FactoryBot.create(:user)
	  			sale = FactoryBot.build(:sale, user: user)
	  			expect(sale.user).to eq user
	  		end
	  	
	  		it "should belong to a book" do
	  			book = FactoryBot.create(:book)
	  			sale = FactoryBot.build(:sale, book: book)
	  			expect(sale.book).to eq book
	  		end
	  	

	  	
	  end
end
