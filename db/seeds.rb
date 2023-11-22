# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)



#run  rails db:seed to test the users with credentials the application redirects to the dashboard based in role

# db/seeds.rb

testadmin1 = User.create!(email: 'testadmin1@example.com', password: '123456', role: 'admin')

testadmin2 = User.create!(email: 'testadmin2@example.com', password: '123456', role: 'admin')

testadmin3 = User.create!(email: 'testadmin32@example.com', password: '123456', role: 'admin')

testcostumer3 = User.create!(email: 'testcustomer3@example.com', password: '123456', role: 'customer')

testcostumer4 = User.create!(email: 'testcustomer4@example.com', password: '123456', role: 'customer')


testcostumer5 = User.create!(
  email: 'testcustomer5@example.com',
  password: '123456',
  password_confirmation: '123456', # Solo necesario si estás utilizando Devise
  role: 'customer' # o cualquier otro rol que tengas definido
)


testItem1 = Item.create!(name: 'ticket 1 ',price: 10000)

testItem2 = Item.create!(name: 'ticket 2 ',price: 1000)

testItem3 = Item.create!(name: 'ticket 3 ',price: 5000)

testItem4 = Item.create!(name: 'ticket 4 ',price: 500)

testItem5 = Item.create!(name: 'ticket 5 ',price: 20000)

coupon1 = Coupon.create!(code: "CUPON123",discount_type: "flat",
    discount_value: 10,
    max_amount: 50,
    min_purchase_value: 100,
    active: true,
    description: "special discount",
    max_count: 5
  )

coupon2 = Coupon.create!(code: "CUPON12345",discount_type: "percentage",
    discount_value: 100,
    max_amount: 500,
    min_purchase_value: 1000,
    active: true,
    description: "with max_amount limitation",
    max_count: 1
  )

coupon4 = Coupon.create!(code: "COUPON123456789",discount_type: "percentage",
    discount_value: 20,
    max_amount: 5000,
    min_purchase_value: 10000,
    active: true,
    description: "with max_amount limitation",
    max_count: 2
  )



coupon6 = Coupon.create!(code: "COUPON12345678",discount_type: "percentage",
    discount_value: 30,
    max_amount: 5000,
    min_purchase_value: 10000,
    active: true,
    description: "with max_amount limitation",
    max_count: 2
  )


#run rails db:migrate
#and run rails db:seed to use the examples :)
