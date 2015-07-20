class AddVisiblityToSchoolsAndRoles < ActiveRecord::Migration
  def change
    add_column :schools, :visibility, :string
    add_column :roles, :visibility, :string
  end
end
