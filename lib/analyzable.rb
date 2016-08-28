module Analyzable
  # Your code goes here!
  def count_by_brand(product_array)
  	product_stock = 0
  	product_brands = []
  	brand_hash = {}
  	product_array.each {|each_product| (product_brands << each_product.brand).uniq!} # collect unique brands
  	product_brands.each do | each_brand |
  		product_array.each do | each_product| 
  			product_stock += 1 if each_brand == each_product.brand
  		end
  		brand_hash["#{each_brand}"] = product_stock
  		product_stock = 0
  	end
  	brand_hash
  end

  def count_by_name(product_array)
  	product_stock = 0
  	product_names = []
  	name_hash = {}
  	product_array.each {|each_product| (product_names << each_product.name).uniq!} # collect unique brands
  	product_names.each do | each_name |
  		product_array.each do | each_product| 
  			product_stock += 1 if each_name == each_product.name
  		end
  		name_hash["#{each_name}"] = product_stock
  		product_stock = 0
  	end
  	name_hash
  end
   
  def average_price(product_array)
  	avg_price = 0
  	product_array.each {| each_product | avg_price += each_product.price.to_f} # add all product price
  	(avg_price/product_array.length).round(2) # return average of all products in array
  end

  def print_report(product_array)
  	puts "Average Price: $#{average_price(product_array)}"
  	puts "Inventory by Brand:\n"
  	brand_hash = count_by_brand(product_array)
  	brand_hash.each_pair {| each_brand, number | puts "- #{each_brand}: #{number}\n"}
  	puts "Inventory by Name:"
  	name_hash = count_by_name(product_array)
  	name_hash.each_pair {| each_name, number | puts "- #{each_name}: #{number}\n"}
  	return ""
  end

end
