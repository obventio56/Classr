class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :title
      t.integer :creator_id, index: true
      t.string :status
      t.string :visibility
      t.timestamps null: false
    end
  end
end
