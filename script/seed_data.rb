require 'faker'
PASSWORD = "password"

1000.times do |i| 
	#user = User.create!( email: Faker::Internet.email, name: Faker::Name.name, password: PASSWORD, encrypted_password: User.new(password: PASSWORD).encrypted_password )
    book = Book.create!(isbn: "#{rand(0..9)} + #{rand(0..9)} + #{rand(0..9)} + #{rand(0..9)} + #{rand(0..9)} + #{rand(0..9)} + #{rand(0..9)} + #{rand(0..9)} + #{rand(0..9)}",
    	               title: Faker::Lorem.words.join(" "), author: Faker::Name.name, user_id: rand(0..1000), days: rand(1..7))
    p book
end
