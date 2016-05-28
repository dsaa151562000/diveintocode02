class CreateQas < ActiveRecord::Migration
  def change
    create_table :qas do |t|
      t.string :title
      t.text :content
      t.integer :category_id
      t.integer :language_id

      t.timestamps null: false
    end
  end
end
