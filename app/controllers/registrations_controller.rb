class RegistrationsController < Devise::RegistrationsController

  def create
    @user = User.new(sign_up_params)
    @user.role = 'SELLER' unless sign_up_params[:phone].blank?
    @user.balance = 0.0 if @user.is_seller?
    respond_to do |format|
      if @user.save
        if(@user.is_buyer?)
          cart = Cart.new(user: @user)
          cart.save
        end
        format.html { redirect_to root_path, notice: 'User created successfully.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def sign_up_params
    params.require(:user).permit(:name, :role, :email, :password, :password_confirmation, :balance, :address, :phone)
  end

  def account_update_params
    params.require(:user).permit(:name, :role, :email, :password, :password_confirmation, :current_password, :balance, :address, :phone)
  end
end
