class AddDiscountToItem < ActiveRecord::Migration
  def change
    add_column :items, :Discount, :decimal
  end
end
