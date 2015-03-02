json.array!(@work_shops) do |work_shop|
  json.extract! work_shop, :id, :name, :address, :admin
  json.url work_shop_url(work_shop, format: :json)
end
