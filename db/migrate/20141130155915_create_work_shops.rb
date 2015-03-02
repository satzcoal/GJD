class CreateWorkShops < ActiveRecord::Migration
  def change
    create_table :work_shops do |t|
      t.string :name
      t.string :address
      t.string :admin

      t.timestamps
    end
  end
end
