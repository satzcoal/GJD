class Info::Provider < Info::Relationship
  has_history
  has_one :finance, :class_name => 'Info::ProviderFinance', :foreign_key => :parent_id, :dependent => :destroy

  def pid=(value)
    self.rid = value
  end

  def pid
    self.rid
  end

  private
  def generate_num
    if Info::Provider.count == 0
      self.pid, self.tmp_rid = 'C00001', 1
    else
      _tmp_num = Info::Provider.order(:tmp_rid => :desc).first!.tmp_rid + 1
      self.tmp_rid = _tmp_num
      self.pid = 'P'+('0000' + _tmp_num.to_s)[-5..-1]
    end
  end

  def create_finance_method
    self.create_finance(:amount => 0, :back_amount => 0) unless self.finance
  end
end