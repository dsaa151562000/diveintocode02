class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.references :project, index: true, foreign_key: true
      t.string :customer_name

      t.timestamps null: false
    end
  end
end
