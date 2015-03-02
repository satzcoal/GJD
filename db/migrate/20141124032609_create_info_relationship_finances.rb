class CreateInfoRelationshipFinances < ActiveRecord::Migration
  def change
    create_table :info_relationship_finances do |t|
      t.decimal :amount
      t.integer :parent_id
      t.decimal :back_amount
      t.string :type

      t.timestamps
    end
  end
end
