class AddBasePriceToItem < ActiveRecord::Migration
  def change
    add_column :items, :BasePrice, :decimal
  end
end
