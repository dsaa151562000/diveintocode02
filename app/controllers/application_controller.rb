class ApplicationController < ActionController::Base
  # ・・・
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_action :current_notifications
  
  
  #$ヘッダー通知用
  def current_notifications
    
    if(signed_in?)
    #binding.pry
     #@notifications = Notification.where(recipient_id: current_user.id).order(created_at: :desc).includes({comment: [:blog]})
     @notifications = Notification.where(recipient_id: current_user.id).order(created_at: :desc)
     #binding.pry
    end
    
    @notifications_count = Notification.where(recipient_id: current_user).order(created_at: :desc).unread.count
    #binding.pry
  end
  
  
  protected
    def configure_permitted_parameters
      #devise_parameter_sanitizer.for(:sign_up) <<:name, :image
      #devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:name, :image) }
      #devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation, :image) }
      
      devise_parameter_sanitizer.permit(:sign_in) do |user_params|
          user_params.permit(:name, :email, :password, :password_confirmation, :image)
      end
      #devise_parameter_sanitizer.for(:account_update) << :name
      devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :email, :password, :password_confirmation, :current_password, :image) }
    end
    
end