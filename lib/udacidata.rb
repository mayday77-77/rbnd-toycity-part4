require_relative 'find_by'
require_relative 'errors'
require_relative '../data/schema'
require_relative '../lib/analyzable'
require 'csv'

class Udacidata
  # Your code goes here!
  @@product_array = []
  create_finder_methods :brand, :name

  def self.create(attributes = nil) # create new product
  	product_new = Product.new(attributes)  	
  	check_ID_not_found?(product_new.id) ? write_to_database(product_new) : product_id_exits
  	product_new
  end

  def self.check_ID_not_found?(product_id)
  	load_database
  	product_exists = @@product_array.select {|each_product| each_product.id == product_id}
  	product_exists.empty? ? true : false
  end

  def self.all # display product array
     load_database
     @@product_array
  end

  def self.write_to_database(product) # save 1 product information to CSV file for every creation
  	database_file = File.dirname(__FILE__) + "/../data/data.csv"
  	CSV.open(database_file, "a+") do | csv |
  		csv << ["#{product.id}","#{product.brand}","#{product.name}","#{product.price}"];nil
  	end
  end

  def self.rewrite_to_database(product_array) # rewrite to database CSV if a product is being destroyed
  	database_file = File.dirname(__FILE__) + "/../data/data.csv"
  	File.delete(database_file) if File.exist?(database_file) # remove the database file 
  	db_create # recreate the database file with headers
  	# rewrite the products into database CSV
  	product_array.each {| product | write_to_database(product)};nil
  end

  def self.load_database # loads the CSV file into product array
  	  database_file = File.dirname(__FILE__) + "/../data/data.csv"
  	  @@product_array.clear 
  	  # :headers option to inform that headers exist
  	  CSV.foreach(database_file, :headers => true) do | row |
  	  	each_product = Product.new(id: row[0], brand: row[1], name: row[2], price: row[3]) # assign values into a product class 
  	  	@@product_array << each_product # create product array
  	  end
  end

  def self.first(options = {})
  	load_database
  	if options.to_s.to_i == 0 # if no number passed in, print first element
  		@@product_array.first
  	else  # else loop through product array and print the number of products accordingly
  		new_product_array = [] 
  		options.times { | each_time | new_product_array << @@product_array[each_time]}
  		new_product_array
  	end
  end

  def self.last(options = {})
  	load_database
  	if options.to_s.to_i == 0 # if no number passed in, print last element
  		@@product_array.last
  	else  # else loop through product array and print the number of products accordingly
  		new_product_array = [] 
  		options.times { | each_time | new_product_array << @@product_array.reverse[each_time]}
  		new_product_array.reverse
  	end
  end

  def self.find(product_id)
  	load_database
  	search_product = @@product_array.select {| each_product| each_product.id == product_id} # select the product by ID
  	if search_product.empty?
  		product_not_found(product_id)
  	else
  		search_product.first
  	end

  end

  def update(options = {}) #instance method used by product
	@brand = options[:brand] if options[:brand]
	@price = options[:price] if options[:price]
    Product.rewrite_to_database(@@product_array)
    self
  end

  def self.destroy(product_id)
  	# return the product to be destroyed and exception handling is being handle at the same time
  	destroy_product = find(product_id) 
  	# delete the product from array and rewrite to database CSV
  	@@product_array.reject! {| each_product| each_product.id == product_id}; nil # delete the product from the product array
  	rewrite_to_database(@@product_array)  	
  	destroy_product
  end

  def self.where(options = {})
  	load_database
  	# select product by brand or name
  	if options[:brand]
  		search_product = @@product_array.select {| each_product| each_product.brand == options[:brand]}
  	else
  		search_product = @@product_array.select {| each_product| each_product.name == options[:name]}
  	end
  	search_product
  end

  def self.product_not_found(product_id) # handle product not found exceptions
  	begin
			raise ProductNotFoundError
		rescue Exception => e
			puts e.message + ": '#{product_id}' is not found"
		end
  end

  def self.product_id_exits
  	begin
			raise ProductIDExists
		rescue Exception => e
			puts e.message + "\nProduct ID already exists"
		end
  end

end
