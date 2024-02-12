class Public::SearchesController < ApplicationController
  def genre_search
    @genre_id = params[:genre_id]
    @recipes = Recipe.where(genre_id: @genre_id)
  end
  
  def search
    @model = params[:model]
    @content = params[:content]
    @method = params[:method]
    if @model == "recipe"
      @records = Recipe.search_for(@content, @method)
    end
  end
      
end
