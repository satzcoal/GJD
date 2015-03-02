class Info::ProviderFinDtl < Info::RelationshipFinDtl
  has_history
  belongs_to :finance, :class_name => 'Info::ProviderFinance', foreign_key: :fin_id

  def pfd_id
    rfd_id
  end

  def pfd_id= value
    self.rfd_id = value
  end

  private
  def generate_rfd_id
    cdate = Time.now.localtime().strftime('%Y%m%d')
    wherestr = "date_tmp = '#{cdate}'"
    if self.order_id.nil?
      autoWord = 'M'
      wherestr += ' and order_id is null'
    else
      autoWord = 'A'
      wherestr += ' and order_id is not null'
    end

    if Info::CustomerFinDtl.where(wherestr).count == 0
      self.cfd_id, self.date_tmp, self.num_tmp = 'CFD_' + autoWord + '_' + cdate + '0001', cdate, 1
    else
      _tmp_num = Info::CustomerFinDtl.where(wherestr).order(:num_tmp => :desc).first!.num_tmp + 1
      self.num_tmp = _tmp_num
      self.date_tmp = cdate
      self.cfd_id = 'PFD_' + autoWord + '_' + cdate + ('000' + _tmp_num.to_s)[-4..-1]
    end
  end
end
