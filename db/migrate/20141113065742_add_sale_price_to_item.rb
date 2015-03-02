class AddSalePriceToItem < ActiveRecord::Migration
  def change
    add_column :items, :SalePrice, :decimal
  end
end
