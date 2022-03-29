








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

  end
end
