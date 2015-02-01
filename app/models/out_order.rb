class OutOrder < ActiveRecord::Base
  belongs_to :base_order
  has_many :out_order_items, :foreign_key => "OutOrder_id", :dependent => :destroy
  has_many :out_order_item_hises, :foreign_key => "OutOrder_id", :dependent => :destroy
end
