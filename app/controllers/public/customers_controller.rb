class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  def show
    @customer = Customer.find(params[:id])
    @recipes = @customer.recipes.published.page(params[:page]).per(10)
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    customer = Customer.find(params[:id])
    customer.update(customer_params)
    redirect_to customer_path(customer.id)
  end

  def unsubscribe
  end

  def withdraw
    @customer = Customer.find(current_customer.id)
    @customer.update(is_active: false)
    reset_session
    redirect_to current_customer
  end
  
  def likes
    likes = Like.where(customer_id: current_customer.id).pluck(:recipe_id)
    @like_list = Recipe.find(likes)
    @like_list = Kaminari.paginate_array(@like_list).page(params[:page]).per(12)
  end
  
  def draft
    @recipes = current_customer.recipes.where(status: %i[draft unpublished]).page(params[:page]).reverse_order.per(10)
    @genres = Genre.all
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :email, :image)
  end
end
