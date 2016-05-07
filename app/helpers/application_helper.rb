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
     
end
