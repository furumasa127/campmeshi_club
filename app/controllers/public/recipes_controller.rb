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
    if params[:draft].present?
      @recipe.status = :draft
    else
      @recipe.status = :published
    end
    if params[:draft]

      if @recipe.save
        redirect_to draft_path(@recipe.customer_id), notice: '下書きが保存されました。'
      else
        render :new
      end
    else

      if @recipe.save(context: :publish)
        redirect_to recipe_path(@recipe.id), notice: '投稿しました'
      else
        flash.now[:alert] = "投稿できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください"
        render :new
      end

    end
  end

  def index
    @recipes = Recipe.published.order(created_at: :desc).page(params[:page]).per(12)
    @genres = Genre.all
  end

  def show
    @recipe = Recipe.find(params[:id])
    @recipe.recipe_details = RecipeDetail.where(recipe_id: params[:id])
    @recipe.recipe_steps = RecipeStep.where(recipe_id: params[:id])
    @comment = Comment.new
  end

  def destroy
    recipe = Recipe.find(params[:id])
    recipe.destroy
    redirect_to recipes_path
  end

  def edit
    @recipe = Recipe.find(params[:id])
    @customer = current_customer
  end

  def update
    @customer = current_customer
    @recipe = Recipe.find(params[:id])

    @recipe.assign_attributes(recipe_params)

    if params[:draft].present?
      @recipe.status = :draft
      notice_message = "下書きを保存しました"
      redirect_path = draft_path(@recipe.customer_id)
    elsif params[:unpublished].present?
      @recipe.status = :unpublished
      notice_message = "非公開にしました.。"
      redirect_path = draft_path(@recipe.customer_id)
    else
      @recipe.status = :published
      notice_message = "投稿を更新しました。"
      redirect_path = recipe_path(@recipe)
    end

    if @recipe.save
      redirect_to redirect_path, notice: notice_message
    else
      flash.now[:alert] = "投稿できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください"
      render :edit
    end
  end

  private

  def recipe_params
    params.require(:recipe).permit(
      :dish_name, :explanation, :difficulty, :cooking_time, :status, :image, :genre_id,
      recipe_details_attributes: [:id, :ingredient, :quantity, :_destroy],
      recipe_steps_attributes: [:id, :cooking_process, :image, :_destroy]
      )
  end
end
