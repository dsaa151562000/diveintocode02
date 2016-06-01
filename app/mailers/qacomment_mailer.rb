class QacommentMailer < ApplicationMailer
    
 default from: "from@example.com"

  def contact_email(user, post)
    @message= post.content
     
    mail to: user.email, subject: @message
  end
end
