class CreatePrincipals < ActiveRecord::Migration
  def change
    create_table :principals do |t|
      t.string :name
      t.integer :school_id

      t.timestamps null: false
    end
  end
end
