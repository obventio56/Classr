class CreateWhitelistedEmails < ActiveRecord::Migration
  def change
    create_table :whitelisted_emails do |t|
      t.string :email
      t.integer :school_id

      t.timestamps null: false
    end
  end
end
