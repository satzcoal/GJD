class CreateBaseOrders < ActiveRecord::Migration
  def change
    create_table :base_orders do |t|
      t.string :OrderId
      t.string :type
      t.decimal :Total
      t.decimal :FactTotal
      t.string :From
      t.string :FromAddress
      t.string :From_Back
      t.string :From_BackAccountNum
      t.string :From_BackAccountName
      t.string :To
      t.string :ToAddress
      t.string :To_Back
      t.string :To_BackAccountNum
      t.string :To_BackAccountName
      t.string :MoneyState
      t.string :State
      t.date :CreateTime
      t.string :CreateUser

      t.timestamps
    end
  end
end
