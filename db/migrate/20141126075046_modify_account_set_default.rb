class ModifyAccountSetDefault < ActiveRecord::Migration
  def change
    change_column :finance_accounts, :amount, :decimal, :default => 0
  end
end
