class CreateCoupons < ActiveRecord::Migration[7.0]
  def change
    create_table :coupons do |t|
      t.string :code
      t.string :discount_type
      t.integer :discount_value
      t.integer :max_amount
      t.integer :min_purchase_value
      t.boolean :active
      t.integer :count_used

      t.timestamps
    end
  end
end
