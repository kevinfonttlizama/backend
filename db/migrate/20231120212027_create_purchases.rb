class CreatePurchases < ActiveRecord::Migration[7.1] # Asegúrate de que la versión sea la correcta para tu aplicación
  def change
    create_table :purchases do |t|
      t.integer :user_id 
      t.decimal :total_amount, precision: 10, scale: 2 
      t.integer :coupon_id 


      t.timestamps
    end
  end
end
