class Info::CustomerFinance < Info::RelationshipFinance
  has_history
  belongs_to :customer, :class_name => 'Info::Customer', foreign_key: :parent_id
  has_many :fin_dtls, :class_name => 'Info::CustomerFinDtl', foreign_key: :fin_id
end
