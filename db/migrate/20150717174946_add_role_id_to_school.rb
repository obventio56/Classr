class AddRoleIdToSchool < ActiveRecord::Migration
  def change
    add_reference :schools, :role, index: true
  end
end
