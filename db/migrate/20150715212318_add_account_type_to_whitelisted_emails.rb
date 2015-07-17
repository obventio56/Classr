class AddAccountTypeToWhitelistedEmails < ActiveRecord::Migration
  def change
    add_column :whitelisted_emails, :account_type, :string
  end
end
