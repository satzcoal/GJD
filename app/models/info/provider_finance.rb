class Info::ProviderFinance < Info::RelationshipFinance
  has_history
  belongs_to :provider, :class_name => 'Info::Provider', foreign_key: :parent_id
  has_many :fin_dtls, :class_name => 'Info::ProviderFinDtl', foreign_key: :fin_id
end
