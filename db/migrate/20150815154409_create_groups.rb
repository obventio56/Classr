class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.integer :course_id, index: true
      t.integer :teacher_id, index: true
      t.timestamps null: false
    end
  end
end
