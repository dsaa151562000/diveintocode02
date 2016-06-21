module ApplicationHelper
    
    def profile_img(user)
      if user.provider == 'facebook'
         img_url = "https://graph.facebook.com/#{user.uid}/picture?width=320&height=320"
      elsif user.provider == 'twitter'
         img_url = "http://furyu.nazo.cc/twicon/#{user.name}"
      else
         if user.image.present?
            img_url = user.image.thumb.url
         else
             gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
            img_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
         end
      end
     end
     
      # 引数で与えられたユーザーのGravatar画像を返す
    def gravatar_for(user)
        gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
        gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
        image_tag(gravatar_url, alt: user.name, class: "gravatar")
    end
    
    
   def member?(other_user)
    Membership.find_by(user_id: other_user.id)
    #binding.pry
   end
     
    #プロジェクトに参加していますか？ 
    def member_project_num?( pj_num,pj_user )
     @exist= Membership.where(["project_id = ? and user_id = ?", pj_num, pj_user])
         if  @exist.empty?
           return nil
        else
           return 1
       end
    end
   
   def pj_member?(pj_num)
      #参加しているか確認する
     #Membership.where(project_id: pj_num)
    @exist= Membership.where(["project_id = ? and user_id = ?", pj_num, current_user.id])
    #binding.pry
    if  @exist.empty? then
     return nil
     end
      return 1
    end
  end
