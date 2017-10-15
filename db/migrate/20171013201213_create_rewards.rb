class CreateRewards < ActiveRecord::Migration
  def change
    create_table :rewards do |t|
      t.integer :user_id

      t.integer :amount
      t.integer :status
      t.string :giftrocket_id, index: true, unique: true
      t.string :public_token, index: true, unique: true, null: false

      t.timestamps null: false
    end
  end
end
