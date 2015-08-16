class CreateGroupRoles < ActiveRecord::Migration
  def change
    create_table :group_roles do |t|
      t.integer :role_id, index: true
      t.integer :group_id, index:true
      t.timestamps null: false
    end
  end
end
