class CreateInfoRelationshipFinDtls < ActiveRecord::Migration
  def change
    create_table :info_relationship_fin_dtls do |t|
      t.integer :fin_id
      t.datetime :do_time
      t.boolean :in_or_out
      t.decimal :money
      t.integer :status_id
      t.string :comment
      t.integer :order_id
      t.string :rfd_id
      t.string :date_tmp
      t.integer :num_tmp
      t.string :type

      t.timestamps
    end
  end
end
