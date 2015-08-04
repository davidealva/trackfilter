class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?

	def after_sign_in_path_for(resource_or_scope)
	  if resource.sign_in_count == 1
	      edit_user_profile_path(current_user[:id])
	  else
	     root_path
	  end
	end
  
	protected

	  def configure_permitted_parameters
	    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :stripe_card_token, :email, :password, :password_confirmation, :remember_me, :acct_type) }
	    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:username, :email, :password, :remember_me) }
	  end
end
