class CreateRewardPayouts < ActiveRecord::Migration
  def change
    create_table :reward_payouts do |t|
      t.integer :reward_id
      t.integer :catalog_product_id

      t.string :status
      t.string :giftrocket_id
      t.string :error
      t.text :data

      t.datetime :completed_at
      t.timestamps null: false
    end
  end
end
