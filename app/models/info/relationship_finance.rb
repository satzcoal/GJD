class Info::RelationshipFinance < ActiveRecord::Base
  def create_in_finance_detail(money, order_id, auto_commit_flag=true)
    detail = fin_dtls.build(:money => money, :order_id => order_id, :in_or_out => true, :comment => param_validate(money, order_id))
    if auto_commit_flag
      detail.proceed
    else
      detail.save
    end

  end

  def create_out_finance_detail(money, order_id)
    fin_dtls.build(:money => money, :order_id => order_id, :in_or_out => false, :comment => param_validate(money, order_id)).save
  end

  private
  def param_validate(money, order_id)

    raise 'Money must be BigDecimal or Integer or Float' unless money.is_a?(BigDecimal) || money.is_a?(Integer) || money.is_a?(Float)

    if order_id.is_a? Integer
      'AUTO_MSG: SUCCESS'
    else
      "AUTO_MSG: WARN! order_id is [#{order_id}]"
    end
  end
end
