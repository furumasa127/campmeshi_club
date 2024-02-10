class Public::RecipesController < ApplicationController
  before_action :authenticate_customer!, except: [:index]

  def new
    @recipe = Recipe.new
    @recipe.recipe_details.build
    @recipe.recipe_steps.build
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.customer_id = current_customer.id
    if @recipe.save
      redirect_to recipe_path(@recipe.id), notice: '投稿しました'
    else
      flash.now[:alert] = '投稿に失敗しました。必須の項目を入力してください'
      render :new
    end
  end

  def index
    @recipes = Recipe.order(created_at: :desc)
    @genres = Genre.all
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  private

  def recipe_params
    params.require(:recipe).permit(
      :dish_name, :explanation, :difficulty, :cooking_time, :image, :genre_id,
      recipes_details_attributes: [:id, :ingredient, :quantity],
      recipe_steps_attributes: [:id, :cooking_process]
      )
  end
end
