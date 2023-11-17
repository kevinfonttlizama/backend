# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)



#run  rails db:seed to test the users with credentials the application redirects to the dashboard based in role 

testuser1 = User.New(email: 'testsubject@example.com', password: "123456", role:admin)
testuser2 = User.New(email: 'adminsubject@example.com', password: "123456", role:admin)
