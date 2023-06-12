class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
  $app_fee = 0.03

  def authenticate_user!
    if user_signed_in?
      super
    else
      redirect_to new_user_session_url
      ## if you want render 404 page
      ## render :file => File.join(Rails.root, 'public/404'), :formats => [:html], :status => 404, :layout => false
    end
  end

  def validate_provider
    unless current_user.is_provider?
      redirect_to root_path
    end
  end

  def validate_admin
    unless current_user.is_admin?
      redirect_to root_path
    end
  end
end
