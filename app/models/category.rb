# encoding: utf-8
class Category < ActiveRecord::Base
  has_history
  validates_presence_of :Name, :message => "品目名称不能为空"
  validates_uniqueness_of :Name, :message => "品目名称已存在"
  has_many :sub_categories ,:foreign_key=>"CategoryId"
end
