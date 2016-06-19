class CreateProjecttasks < ActiveRecord::Migration
  def change
    create_table :projecttasks do |t|
      t.references :user, index: true, foreign_key: true
      t.references :project, index: true, foreign_key: true
      t.string :projecttask_title
      t.text :projecttask_content
      t.datetime :projecttask_deadline
      t.integer :projecttask_charge_id
      t.boolean :projecttask_done
      t.integer :projecttask_status

      t.timestamps null: false
    end
  end
end
