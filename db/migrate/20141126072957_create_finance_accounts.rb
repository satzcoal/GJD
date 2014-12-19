class CreateFinanceAccounts < ActiveRecord::Migration
  def change
    create_table :finance_accounts do |t|
      t.decimal :amount

      t.timestamps
    end
  end
end
