#encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#  在这里可以做系统部署数据初始化
# e.g.: 创建管理员用户、初始化权限、基本信息配置
#删除所有用户
#User.delete_all
#admin= User.Create([{name: 'admin'}])
#Category.delete_all
#caretegories = Category.Create([{Name: "", Type: ""}]

#初始化 菜单
site = Origin::Site.first
site = Origin::Site.new unless site
site.title = '管家爹' unless site.title
site.sidebar_items.destroy_all
if (site.sidebar_items.empty?)
  site.sidebar_items.build(name: '控制台', url: '/')

  site_item = site.sidebar_items.build(name: site.title, url: '#')
  site_item.sub_items.build(name: '基本设置', url: '/origin/site')
  site_item.sub_items.build(name: '数据报表', url: '#')
  site_item.sub_items.build(name: '公司资料', url: '#')

  peizhi_item = site.sidebar_items.build(name: '配置管理', url: '#')
  peizhi_item.sub_items.build(name: '品目配置', url: '/categories')
  peizhi_item.sub_items.build(name: '物品配置', url: '/items')
  peizhi_item.sub_items.build(name: '仓库配置', url: '/go_downs')
  peizhi_item.sub_items.build(name: '生产流水配置',url: '/batches')
  peizhi_item.sub_items.build(name: '生产车间配置',url: '/work_shops')

  dingdan_item = site.sidebar_items.build(name: '订单管理', url: '#')
  dingdan_item.sub_items.build(name: '采购订单', url: '/purchase_orders')
  dingdan_item.sub_items.build(name: '销售订单', url: '/o_orders')
  dingdan_item.sub_items.build(name: '采购订单1', url: '/sale_orders')

  dingdan_item = site.sidebar_items.build(name: '生产管理', url: '#')
  dingdan_item.sub_items.build(name: '原料出库', url: '/item_out_orders')
  dingdan_item.sub_items.build(name: '产品入库', url: '/make_orders')

  cangku_item = site.sidebar_items.build(name: '仓库管理', url: '#')
  cangku_item.sub_items.build(name: '库存查询', url: '/go_down_items')
  cangku_item.sub_items.build(name: '入库管理', url: '/in_orders')
  cangku_item.sub_items.build(name: '出库管理', url: '/out_orders')
  cangku_item.sub_items.build(name: '物品转库', url: '/move_orders')
  cangku_item.sub_items.build(name: '入库历史', url: '/go_down_items')
  cangku_item.sub_items.build(name: '出库历史', url: '/go_down_items')

  caiwu_item = site.sidebar_items.build(name: '财务管理', url: '#')
  caiwu_item.sub_items.build(name: '财务信息汇总', url: '/finance/show')
  caiwu_item.sub_items.build(name: '应收款汇总', url: '/finance/index_in')
  caiwu_item.sub_items.build(name: '应付款汇总', url: '/finance/index_out')
  caiwu_item.sub_items.build(name: '客户出入账管理', url: '/info/customer_fin_dtls')
  caiwu_item.sub_items.build(name: '供应商出入账管理', url: '/info/provider_fin_dtls')

  kehu_item = site.sidebar_items.build(name: '资料管理', url: '#')
  kehu_item.sub_items.build(name: '客户资料管理', url: '/info/customers')
  kehu_item.sub_items.build(name: '供应商资料管理', url: '/info/providers')

  xitong_item = site.sidebar_items.build(name: '系统管理', url: '#')
  xitong_item.sub_items.build(name: '用户管理', url: '/origin/users')
  xitong_item.sub_items.build(name: '角色管理', url: '/origin/roles')
  xitong_item.sub_items.build(name: '菜单项管理', url: '/origin/sidebar_items')
end
site.save


#权限
role = Origin::Role.find_or_create_by(name: '超级管理员') do |r|
  r.adminFlag = true
  r.save
end

#管理员 admin
Origin::User.find_or_create_by(name: 'admin') do |user|
  user.hashed_password = 'b38dccdaff403e93e883e12ac0decabfd3a59f77acddc375306e4e2223dcb09a'
  user.salt = '702160211035000.14183056038145636'
  user.role_id = role.id
  user.pname = "123"
  user.save
end

#一般管理员
role = Origin::Role.find_or_create_by(name: '一般管理员') do |r|
  r.adminFlag = false
  Origin::SidebarItem.where.not(:parent_id => nil).each_with_index do |item, index|
    next if index % 2 == 0
    r.sidebar_items.push(item)
  end
  r.save
end

#用户lee
Origin::User.find_or_create_by(name: 'lee') do |user|
  user.hashed_password = '78453a624e096db5caaf0d1c1aaecc486b5ca61edccf05bdc736c8a6f8ba823e'
  user.salt = '702160181549000.9970450566573815'
  user.role_id = role.id
  user.pname = "456"
  user.save
end

# 添加供应商
x = Info::Provider.find_or_create_by(name: '李靖超').save

##添加客户
#Info::Customer.delete_all
#c = Info::Customer.new
#c.name = "柳娜"
#c.save()


# 添加仓库信息
GoDown.destroy_all
g = GoDown.new
g.GoDownId = "G_0001"
g.Name = "海淀一号"
g.Address = "大柳树北路17号"
g.Admin = "陈晓雨"
g.Tel = "18612345678"
g.save()

#添加品目信息
SubCategory.destroy_all
Category.destroy_all
#添加品目1
pm = Category.new
pm.Name = "凡士林"
pm.Type= "原料"
#物品规格
pm.sub_categories.build(:Name => "10ML")
pm.save()

#添加品目2
pm1 = Category.find_or_create_by(:Name => "防晒霜")
pm1.Name = "防晒霜"
pm1.Type= "产品"
#物品规格
pm1.sub_categories.build(:Name => "20ML")
pm1.save()


#添加物品信息
Item.destroy_all
item = Item.new
item.Name= "百雀羚"
item.CategoryName= "凡士林"
item.subCategoryName = "10ML"
item.ItemId = "i_00001"
item.Type= "原料"
item.BasePrice = 120;
item.SalePrice = 300;
item.Discount = 8
item.save()

item = Item.new
item.Name= "欧莱雅"
item.CategoryName= "防晒霜"
item.subCategoryName = "10ML"
item.ItemId = "i_00002"
item.Type= "产品"
item.BasePrice = 120;
item.SalePrice = 300;
item.Discount = 8
item.save()

#生产批次
Batch.destroy_all
bh = Batch.new
bh.Batchid = "B_00001"
bh.Date= "2014-11-30"
#bh.Date = Time.now.to_formatted_s(:db)
bh.save()
bh1 = Batch.new
bh1.Batchid = "B_00002"
bh1.Date= "2014-12-01"
bh1.save()

#生产车间  车间名称  位置  管理员
#WorkShop.delete_all
workshop = WorkShop.find_or_create_by(:name => "1号线")
workshop.address = "装盒002"
workshop.admin = "装盒人甲"
workshop.save()

workshop = WorkShop.find_or_create_by(:name => "2号线")
workshop.address = "装盒002"
workshop.admin = "装盒人乙"
workshop.save()

workshop = WorkShop.find_or_create_by(:name => "3号线")
workshop.address = "装盒003"
workshop.admin = "装盒人丙"
workshop.save()


#清空各种订单
BaseOrder.delete_all
OrderItem.delete_all

#清空库存信息
GoDownItem.delete_all

#清空入库单
InOrder.delete_all

#出库单
OutOrder.delete_all
#出库单详细
OutOrderItem.delete_all
OutOrderItemHis.delete_all


