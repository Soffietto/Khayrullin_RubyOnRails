class ProductsController < ApplicationController
  before_action :authenticate_user!

  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # expose :product
  # expose :comment, -> {product.comments.new}


  def index
    products = Product.all
    products = products.where("title ILIKE ?", "%#{params[:search]}%") if params[:search]
    
    @products = products.map {|product| ProductDecorator.new(product, current_user)}

  end

  def show
    @comment = Comment.new
  end

  def new
    @product = Product.new
  end

  def edit
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to @product, notice: 'Product was successfully created.'
    else
      render :new
    end
  end

  def update
    if @product.update(product_params)
      redirect_to @product, notice: 'Product was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    if @policy.destroy?
      @product.destroy
    else
      redirect_to root_path, alert: "Sorry, you don't have perms" and return
    end

    redirect_to products_url, notice: 'Product was successfully destroyed.' and return
  end

  private
    def set_product
      @product = Product.find(params[:id])
      @policy = ProductPolicy.new(@product, current_user)
    end

    def authorize!
      action = params[:action] # destroy
      redirect_to root_path, alert: "Sorry, you don't have perms"
    end

    def product_params
      params.require(:product).permit(:title, :description, :price, :amount)
    end
end
