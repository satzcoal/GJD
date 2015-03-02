json.array!(@items) do |item|
  json.extract! item, :id, :ItemId, :Name, :CategoryId, :CategoryName, :subCategoryid, :subCategoryName, :Type, :BasePrice, :SalePrice, :Discount
  json.url item_url(item, format: :json)
end
