class Module
  def create_finder_methods(*attributes)
    # Your code goes here!
    # Hint: Remember attr_reader and class_eval
    attributes.each do | each_attribute | # pass in the attribute name brand and name
    	new_method = %Q{
    		def self.find_by_#{each_attribute} (val)
    			load_database
    			search_product = @@product_array.select {| each_product| each_product.#{each_attribute} == val } 
  				search_product.first
    		end
    	}
    	class_eval(new_method) # create methods on the fly based on brand and name
    end
  end

end
