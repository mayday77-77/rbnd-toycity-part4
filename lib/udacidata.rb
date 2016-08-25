require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata
  # Your code goes here!

  def self.create(attributes = nil)
  	product_new = Product.new(attributes)
  	write_to_database(product_new)
  end

  def self.all
     database = File.dirname(__FILE__) + "/../data/data.csv"
     #array = CSV.read(database)
     CSV.foreach(database) do | row |
     	puts row.inspect
     end
    	
  end

  def self.write_to_database(product)
  	database = File.dirname(__FILE__) + "/../data/data.csv"
  	CSV.open(database, "a+") do | csv |
  		csv << ["1","2"]
  	end
  end

end
