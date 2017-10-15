class CatalogProduct < ActiveRecord::Base
  has_many :skus, class_name: "CatalogProductSku", :dependent => :destroy
end
