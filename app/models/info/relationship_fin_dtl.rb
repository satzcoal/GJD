class Info::RelationshipFinDtl < ActiveRecord::Base
  belongs_to :finance, :class_name => 'Info::CustomerFinance', foreign_key: :fin_id
  before_create :generate_rfd_id

  def proceed
    self.transaction do
      return if self.status_id != 0
      self.status_id = 1
      self.save
      money = self.money
    end

    unless self.in_or_out
      money = 0 - money
    end

    self.finance.amount = self.finance.amount + money
    self.finance.save
    Finance::Account.amount_change(money)
  end
end
