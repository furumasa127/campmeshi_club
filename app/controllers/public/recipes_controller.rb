class Public::RecipesController < ApplicationController
  before_action :authenticate_customer!, except: [:index]
  
  def index
  end
  
  def new
  end
  
  def create
  end
  
  def show
  end
end
