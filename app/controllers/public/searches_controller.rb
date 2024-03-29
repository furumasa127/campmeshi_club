class Public::SearchesController < ApplicationController
  def genre_search
    @genre_id = params[:genre_id]
       @recipes = Recipe.published.where(genre_id: @genre_id).page(params[:page]).per(10)
    @genres = Genre.all
  end
  
  def search
    @content = params[:content]
    @method = params[:method]
    @records = Recipe.published.search_for(@content, @method).page(params[:page]).per(10)
    @genres = Genre.all
  end
      
end