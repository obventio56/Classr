class CreateWhiteListEntries < ActiveRecord::Migration
  def change
    create_table :white_list_entries do |t|
      t.string :entry
      t.string :entry_type
      t.string :for_account_type
      t.references :school, index: true

      t.timestamps null: false
    end
  end
end
