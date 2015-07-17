class AddUserCreatedToWhitelistedEmails < ActiveRecord::Migration
  def change
    add_column :whitelisted_emails, :user_created, :boolean
  end
end
