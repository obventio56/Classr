class AddPrincipalIdToSchool < ActiveRecord::Migration
  def change
    add_column :schools, :principal_id, :integer
  end
end
