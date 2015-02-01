class BaseOrder < ActiveRecord::Base
  has_many :order_items,:foreign_key=> "BaseOrder_id" , :dependent => :destroy
  has_many :order_item_his , :dependent => :destroy
  has_many :billhis , :dependent => :destroy
  has_many :in_orders,:foreign_key => "Order_id"
  has_many :out_orders, :foreign_key =>  "Order_id", :dependent => :destroy
end
