class AddPrincipalIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :principal_id, :integer
  end
end
