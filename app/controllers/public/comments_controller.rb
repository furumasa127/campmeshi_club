class Public::CommentsController < ApplicationController
  before_action :authenticate_customer!
  
  def create
    recipe = Recipe.find(params[:recipe_id])
    comment = current_customer.comments.new(comment_params)
    comment.recipe_id = recipe.id
    comment.save
    redirect_to recipe_path(recipe)
  end
  
  def destroy
    Comment.find(params[:id]).destroy
    redirect_to recipe_path(params[:recipe_id])
  end
  
  def comment_params
    params.require(:comment).permit(:comment)
  end
end
