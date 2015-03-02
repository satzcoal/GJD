class ModifyRfDstatusDefaultValue < ActiveRecord::Migration
  def change
    change_column :info_relationship_fin_dtls, :status_id, :integer, :default => 0
  end
end
