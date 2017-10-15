task :catalog_update => :environment do
  Giftrocket::Catalog.list.map do |product|
    item = CatalogProduct.find_or_create_by(giftrocket_id: product.raw[:id]) do |item|
      item.name = product.raw[:name]
      item.category = product.raw[:category].try(:upcase)
      item.country = product.raw[:country]
    end

    product.raw[:skus].map do |sku|
      CatalogProductSku.find_or_create_by({
        catalog_product_id: item.id,
        min: sku[:min],
        max: sku[:min],
      })
    end
  end
end

task :catalog_destroy => :environment do
  CatalogProduct.all.destroy_all
end
