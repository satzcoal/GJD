# encoding: utf-8
class SubCategory < ActiveRecord::Base
  validates_presence_of :Name, :message => "不能为空"
  validates_uniqueness_of :Name, :message => "已存在"
  belongs_to :category
end
