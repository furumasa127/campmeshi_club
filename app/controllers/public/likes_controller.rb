class Public::LikesController < ApplicationController
  before_action :authenticate_customer!
  
  def create
    recipe = Recipe.find(params[:recipe_id])
    like = current_customer.likes.new(recipe_id: recipe.id)
    like.save
    redirect_to recipe_path(recipe)
  end
  
  def destroy
    recipe = Recipe.find(params[:recipe_id])
    like = current_customer.likes.find_by(recipe_id: recipe.id)
    like.destroy
    redirect_to recipe_path(recipe)
  end
end
