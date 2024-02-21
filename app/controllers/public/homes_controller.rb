class Public::HomesController < ApplicationController
  def top
      @genres = Genre.all
      @recipes = Recipe.published.latest.page(params[:page]).limit(3)
  end
end
