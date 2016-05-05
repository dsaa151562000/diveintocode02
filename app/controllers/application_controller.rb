class ApplicationController < ActionController::Base
  # ・・・
  before_filter :configure_permitted_parameters, if: :devise_controller?
  protected
    def configure_permitted_parameters
      #devise_parameter_sanitizer.for(:sign_up) <<:name, :image
      #devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:name, :image) }
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation, :image) }
      #devise_parameter_sanitizer.for(:account_update) << :name
      devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :email, :password, :password_confirmation, :current_password, :image) }
    end
end