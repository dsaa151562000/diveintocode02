module SessionsHelper
 def signed_in?
　#ログインしているか、否かを判定するメソッド
  !current_user.nil?
 end
 
 def  current_user=(user)
  @current_user=user
 end
 
 def current_user?(user)
  #(uesr)がカレントユーザーか判定するメソッド
  user == current_user
 end
 
  def sign_out
   #current_userを空いしてトークン情報も削除
   self.current_user = nil
   cookies.delete(:remember_token)
  end
  
  def redirect_back_or(default)
   #ユーザーのいた場所へリダイレクト。なければデフォルト
   redirect_to(session[:return_to]||default)
   session.delete(:return_to)
  end
  
  def store_location
   #ユーザーがいた場所を覚えておくメソッド
   session[:return_to]=request.url
  end
 
    
end
