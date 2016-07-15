class SubmitRequest < ActiveRecord::Base
  belongs_to :task
  belongs_to :user
  belongs_to :charger, class_name: 'User', foreign_key: 'charge_id'
  
  has_many :notifications, dependent: :destroy
  has_many :conversations, through: :notifications, source: :submit_request_id
  #has_many :conversations, through: :notifications, source: :comment
  
  accepts_nested_attributes_for :notifications
  
  #scope :select_submit_request, -> {find(params[:id]) }
  scope :select_submit_request, ->(s_id) {find(s_id)}

end
