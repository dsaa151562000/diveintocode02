class Customer < ActiveRecord::Base
    has_many :projects, dependent: :destroy
    validates :customer_name, presence: { message: "顧客名を入力してください" }
end
