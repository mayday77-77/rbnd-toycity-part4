module Analyzable
  # Your code goes here!
  def count_by_brand(product_array)

  end

  def count_by_name(product_array)

  end
   
  def average_price(product_array)
  	avg_price = 0
  	product_array.each {| each_product | avg_price += each_product.price.to_f}
  	(avg_price/product_array.length).round(2)
  end

  def print_report(product_array)
  	
  end

end
