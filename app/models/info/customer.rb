class Info::Customer < Info::Relationship
  has_history
  has_one :finance, :class_name => 'Info::CustomerFinance', :foreign_key => :parent_id, :dependent => :destroy
  has_many :lowers, :class_name => 'Info::Customer', :foreign_key => :upper_id, :dependent => :nullify
  belongs_to :upper, :class_name => 'Info::Customer', :foreign_key => :upper_id

  def cid=(value)
    self.rid = value
  end

  def cid
    self.rid
  end

  private

  def generate_num
    if Info::Customer.count == 0
      self.cid, self.tmp_rid = 'C00001', 1
    else
      _tmp_num = Info::Customer.order(:tmp_rid => :desc).first!.tmp_rid + 1
      self.tmp_rid = _tmp_num
      self.cid = 'C'+('0000' + _tmp_num.to_s)[-5..-1]
    end
  end

  def create_finance_method
    self.create_finance(:amount => 0, :back_amount => 0) unless self.finance
  end
end
