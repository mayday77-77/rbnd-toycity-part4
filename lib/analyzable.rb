module Analyzable
  # Your code goes here!

  def count_by_brand(product_array)
    count_by_type(product_array, "brand") # passing in brand for the count by type method for differentiation
  end

  def count_by_name(product_array)
    count_by_type(product_array, "name") # passing in name for the count by type method for differentiation
  end

  def count_by_type(product_array, product_type)
    product_stock = 0
    product_type_unique = []
    product_hash = {}
    # collect unique brands or names, using send to dynamically determine which method to call to avoid repetition
    product_array.each {|each_product| (product_type_unique << each_product.send(product_type)).uniq!} 
    product_type_unique.each do | each_type |  # loop through unique types and gather the total in product array
      product_array.each do | each_product| 
        product_stock += 1 if each_type == each_product.send(product_type)
      end
      product_hash["#{each_type}"] = product_stock
      product_stock = 0
    end
    product_hash
  end
   
  def average_price(product_array)
  	avg_price = 0
  	product_array.each {| each_product | avg_price += each_product.price.to_f} # add all product price
  	(avg_price/product_array.length).round(2) # return average of all products in array
  end

   def print_report(product_array) # collate all return report summary as string type
    "Average Price: $#{average_price(product_array)}\n" +
    "Inventory by Brand:\n" +
    print_by_type(product_array, "count_by_brand") +
    "Inventory by Name:\n" +
    print_by_type(product_array, "count_by_name")
    
   end

   def print_by_type(product_array, product_type_method)
      product_string = ""
      # using send to dynamically determine which method to call to avoid repetition
      product_hash = send(product_type_method, product_array)
      product_hash.each_pair {| each_type, number | product_string << "- #{each_type}: #{number}\n"} # printing both type and stock together
      product_string
   end

end
