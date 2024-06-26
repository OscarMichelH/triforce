class ApplicationController < ActionController::Base
  before_action :current_or_guest_user
  skip_before_action :verify_authenticity_token
  $app_fee = 0.03

  # if user is logged in, return current_user, else return guest_user
  def current_or_guest_user
    if current_user && !current_user.is_guest
      if session[:guest_user_id]
        guest_user.destroy
        session[:guest_user_id] = nil
      end
      @current_user = current_user
    else
      @current_user = guest_user
    end
  end

  def authenticate_user!
    if user_signed_in?
      super
    else
      redirect_to new_user_session_url
      ## if you want render 404 page
      ## render :file => File.join(Rails.root, 'public/404'), :formats => [:html], :status => 404, :layout => false
    end
  end

  # find guest_user object associated with the current session,
  # creating one as needed
  def guest_user
    # Cache the value the first time it's gotten.
    @cached_guest_user ||= User.find(session[:guest_user_id] ||= create_guest_user.id)
  rescue ActiveRecord::RecordNotFound # if session[:guest_user_id] invalid
    session[:guest_user_id] = nil
    guest_user
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

  def create_guest_user
    u = User.create(name: "guest", email: "guest_#{Time.now.to_i}#{rand(99)}@example.com", role: "BUYER", is_guest: true)
    u.skip_confirmation!
    u.save!(:validate => false)
    session[:guest_user_id] = u.id
    u
  end
end
