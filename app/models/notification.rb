class Notification < ActiveRecord::Base
    include ActionView::Helpers::TextHelper 
    include ActionView::Helpers:: DateHelper

    belongs_to :sender, class_name: "Conversation", foreign_key: :sender_id
    belongs_to :recipient, class_name: "Conversation", foreign_key: :recipient_id
    #belongs_to :comment, class_name: "Comment", foreign_key: :comment_id
    #belongs_to :submit_request, class_name: "SubmitRequest", foreign_key: :submit_requests_id
    belongs_to :submit_request, class_name: "SubmitRequest", foreign_key: :comment_id

    scope :read, -> { where(read: true) }
    scope :unread, -> { where(read: false) }
    scope :unread_count, -> (user_id) { where(recipient_id: user_id).unread.count }

    def self.sending_pusher(channel_user_id)
        Pusher.trigger("notifications#{channel_user_id}", 'message', {
        unread_count: Notification.unread_count(channel_user_id)
        })
    end
    
    def submit_request_msg(s_id)
         SubmitRequest.select_submit_request(s_id)
    end
    
end
