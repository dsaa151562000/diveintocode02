class CreateQacomments < ActiveRecord::Migration
  def change
    create_table :qacomments do |t|
      t.references :qa, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.string :content

      t.timestamps null: false
    end
  end
end
