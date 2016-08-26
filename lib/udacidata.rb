require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata
  # Your code goes here!
  @@product_array = []

  def self.create(attributes = nil) # create new product
  	product_new = Product.new(attributes)
  	write_to_database(product_new)
  end

  def self.all # display product array
     load_database
     print "#{@@product_array}\n"
  end

  def self.write_to_database(product) # save product information to CSV file
  	database_file = File.dirname(__FILE__) + "/../data/data.csv"
  	CSV.open(database_file, "a+") do | csv |
  		csv << ["#{product.id}","#{product.brand}","#{product.name}","#{product.price}"]
  	end
  	puts product
  end

  def self.load_database # loads the CSV file into product array
  	  database_file = File.dirname(__FILE__) + "/../data/data.csv"
  	  # :headers option to inform that headers exist
  	  CSV.foreach(database_file, :headers => true) do | row |
  	  	each_product = Product.new(id: row[0], brand: row[1], name: row[2], price: row[3]) # assign values into a product class 
  	  		@@product_array << each_product # create product array
  	  end
  end

  def self.first(options = {})
  	#load_database
  	if options.to_s.to_i == 0 # if no number passed in, print first element
  		@@product_array.first
  	else  # else loop through product array and print the number of products accordingly
  		new_product_array = [] 
  		options.times { | each_time | new_product_array << @@product_array[each_time]}
  		print new_product_array
  	end
  end

  def self.last(options = {})
  	#load_database
  	if options.to_s.to_i == 0 # if no number passed in, print last element
  		@@product_array.last
  	else  # else loop through product array and print the number of products accordingly
  		new_product_array = [] 
  		options.times { | each_time | new_product_array << @@product_array.reverse[each_time]}
  		print new_product_array.reverse
  	end
  end

end
