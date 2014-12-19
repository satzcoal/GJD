class Info::Relationship < ActiveRecord::Base
  has_one :finance, :class_name => 'Info::RelationshipFinance', :foreign_key => :parent_id, :dependent => :destroy
  after_create :create_finance_method
  before_create :generate_num

  def has_short_name?
    return self.shortName && !self.shortName.blank?
  end
end