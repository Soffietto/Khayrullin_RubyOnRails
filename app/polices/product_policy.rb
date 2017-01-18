class ProductPolicy

	attr_reader

	def initialize(product, user)
		@product = product
		@user = user
	end

	def destroy?
		@user.role == "administrator"
	end

end
