class CreateTests < ActiveRecord::Migration
  def change
    create_table :tests do |t|
      t.text :html
      t.text :questions_and_answers
      t.integer :role_id, index: true

      t.timestamps null: false
    end
  end
end
