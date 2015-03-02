class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.integer :BaseOrder_id
      t.integer :Item_id
      t.decimal :BasePrice
      t.decimal :SalPrice
      t.decimal :Discount
      t.date :CreateTime
      t.string :BatchId
      t.integer :GoDown_id
      t.integer :Sum

      t.timestamps
    end
  end
end
