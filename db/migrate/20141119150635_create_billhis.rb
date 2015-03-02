class CreateBillhis < ActiveRecord::Migration
  def change
    create_table :billhis do |t|
      t.integer :BaseOrder_id
      t.decimal :Total
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
      t.date :ExceTime
      t.string :ExceUser

      t.timestamps
    end
  end
end
