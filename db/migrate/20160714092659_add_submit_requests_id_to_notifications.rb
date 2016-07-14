class AddSubmitRequestsIdToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :submit_requests_id, :integer
  end
end
