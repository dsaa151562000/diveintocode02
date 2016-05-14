class ContactController < ApplicationController
  
  def index
   @contacts = Contact.all
  end

  def new
    @contact = Contact.new
  end

  def confirm
       @contact = Contact.new(contact_params)
        
    if @contact.valid?
      @msee=@contact.message.gsub(/\r\n|\r|\n/, "<br />").html_safe
    else
      render action: 'new'
    end
  end

  #擬似的なUser構造体を作る
	User2 = Struct.new(:name, :email)

  def thanks
    @contact = Contact.create(contact_params)
    #擬似的なUser構造体を作成する
    user = User2.new("name", "suzuki02yo@gmail.com")
  	# deliverメソッドを使って、メールを送信する
    ContactMailer.contact_email(user, @contact).deliver
  end
  
  private
    def contact_params
      params.require(:contact).permit(:name, :email, :message)
    end

   
end
