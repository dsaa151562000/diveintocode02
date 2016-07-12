class Message < ActiveRecord::Base
  belongs_to :conversation
  belongs_to :user
  
  validates_presence_of :body, :conversation_id, :user_id
  
  #scope :message_new, ->(c_id) { where(conversation_id: c_id).order(created_at: :desc).first }
  scope :message_new, ->(c_id,u_id) { where(conversation_id: c_id).where(user_id: u_id).order(created_at: :desc).first }

  def message_time
    created_at.strftime("%m/%d/%y at %l:%M %p")
  end
  
end
