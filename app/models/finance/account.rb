class Finance::Account < ActiveRecord::Base
  def self.amount_change(money)
    ac = self.first
    ac.amount = ac.amount - money
    ac.save
  end
end
