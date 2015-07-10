class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :functionality_id
      t.string :functionality_type

      t.timestamps null: false
    end
  end
end
