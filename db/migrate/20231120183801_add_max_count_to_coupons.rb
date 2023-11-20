class AddMaxCountToCoupons < ActiveRecord::Migration[7.1]
  def change
    add_column :coupons, :max_count, :integer
  end
end
