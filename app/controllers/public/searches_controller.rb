class Public::SearchesController < ApplicationController
  def genre_search
    @genre_id = params[:genre_id]
    @recipes = Recipe.published.where(genre_id: @genre_id)
    @genres = Genre.all
  end
  
  def search
    @content = params[:content]
    @method = params[:method]
    @records = Recipe.published.search_for(@content, @method)
    @genres = Genre.all
  end
      
end