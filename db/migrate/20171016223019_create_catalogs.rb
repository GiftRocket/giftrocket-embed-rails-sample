class CreateCatalogs < ActiveRecord::Migration
  def change
    create_table :catalog_products do |t|
      t.string :giftrocket_id
      t.string :name
      t.string :category
      t.string :country

      t.timestamps null: false
    end

    create_table :catalog_product_skus do |t|
      t.integer :catalog_product_id
      t.integer :min
      t.integer :max

      t.timestamps null: false
    end
  end
end
