class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :role_type
      t.references :user
      t.references :school

      t.timestamps null: false
    end
  end
end
