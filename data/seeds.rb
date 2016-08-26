require 'faker'
require_relative '../lib/product'

# This file contains code that populates the database with
# fake data for testing purposes

def db_seed
  # Your code goes here!
  10.times do 
  	test_product = Product.create(brand: Faker::Commerce.product_name, name: Faker::Commerce.department, price: Faker::Commerce.price)
  end
end

