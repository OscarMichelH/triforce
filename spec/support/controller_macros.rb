module ControllerMacros
  def login_buyer
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in FactoryBot.create(:buyer)
    end
  end

  def login_seller
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:seller]
      sign_in FactoryBot.create(:seller) # Using factory bot as an example
    end
  end

  def login_admin
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      sign_in FactoryBot.create(:admin) # Using factory bot as an example
    end
  end
end