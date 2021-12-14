# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

## User Type
# 1 - Admin     -   00001
# 2 - Customer  -   00010
# 3 - Both      -   00011

require 'faker'
Faker::Config.random = Random.new(42)

user_list = [
	["test1", "test1@example.com", "pass_test1", 1], # username, email, password, type
	["test2", "test2@example.com", "pass_test2", 2],
	["test3", "test3@example.com", "pass_test3", 3]
]

region_list = [
	["Thai1", "Thailand", "THB", 5.0],
	["Sig1", "Singapore", "SGD", 10.0],
	["Nep1", "Nepal", "NPR", 2.0],
	["US1", "USA", "USD", 1.0],
]

user_list.each { |username, email, password, type|
	User.create(username: username, email:email, password_digest: BCrypt::Password.create(password), user_type: type)
}

region_ids = region_list.map { |title, country, currency, tax|
	Region.create(title: title, country: country, currency: currency, tax: tax)
	Region.find_by(currency: currency).id
}


region_ids.each { |id|
	5.times {
		Product.create(title: Faker::Appliance.brand, description: Faker::Lorem.paragraphs(number: 4), image_url: Faker::Internet.url, price: Faker::Number.decimal(l_digits: 3), sku: Faker::Number.number(digits: 10), stock: Faker::Number.number(digits: 1), regions_id: id)
	}
}