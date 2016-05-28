class ContactMailer < ApplicationMailer
    
  default from: "from@example.com"

  def contact_email(user, post)
    @message= post.message
     
    mail to: user.email, subject: @message
  end
  
  
end
