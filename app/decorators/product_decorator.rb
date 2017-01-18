class ProductDecorator
	
	include ActionView::Helpers::TextHelper

  	attr_reader :product, :user 

	delegate :title, :persisted?, :to_model, :amount, :price, to: :product

	def initialize(product, user)
		@product = product
		@user = user
	end

	def truncated_description
		truncate(@product.description, length:64)
    end

    def current_amount
    	if user.role = "administrator"
			"На складе: #{product.amount} шт." 
    	else
			"На складе: много" 
    	end
    end

end


# product = Product.new description: "sdkjfn;sdf"

# product_decorator = ProductDecorator.new(product)

# if product_decorator.truncated_description == truncate(product.description, length: 64)

# if product_decorator
