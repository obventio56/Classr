class AddCreatedAndRoleIdToWhiteListEntries < ActiveRecord::Migration
  def change
    add_column :white_list_entries, :created_status, :boolean
    add_column :white_list_entries, :creator_role_id, :integer, index: true
  end
end
