class CreateOriginUsers < ActiveRecord::Migration
  def change
    create_table :origin_users do |t|
      t.string :name
      t.string :hashed_password
      t.string :salt
      t.timestamps
    end
  end
end
