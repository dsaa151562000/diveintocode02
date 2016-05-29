class AddColumnToQa < ActiveRecord::Migration
  def change
    add_column :qas, :user_id, :integer
  end
end
