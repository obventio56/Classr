class CreateWhitelistedDomainForStudents < ActiveRecord::Migration
  def change
    create_table :whitelisted_domain_for_students do |t|
      t.string :domain
      t.integer :school_id

      t.timestamps null: false
    end
  end
end
