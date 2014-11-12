class Info::Provider < Info::Relationship

  before_create :generate_provider_num

  def pid=(value)
    self.rid = value
  end

  def pid
    self.rid
  end

  private
  def generate_provider_num
    if Info::Provider.count == 0
      self.pid, self.tmp_rid = 'C00001', 1
    else
      _tmp_num = Info::Provider.order(:tmp_rid => :desc).first!.tmp_rid + 1
      self.tmp_rid = _tmp_num
      self.pid = 'P'+('0000' + _tmp_num.to_s)[-5..-1]
    end
  end
end