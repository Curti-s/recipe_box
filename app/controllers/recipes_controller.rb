class RecipesController < ApplicationController

  before_action :find_recipe, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @recipe = Recipe.all.order("created_at DESC")
  end

  def new
    @recipe = current_user.recipes.build
  end

  def create
    @recipe = current_user.recipes.build(recipe_params)

    if @recipe.save
      redirect_to @recipe, notice: "Succefully created new Recipe"
    else
      render 'new'
    end
  end

  def edit
  end

  def show
  end

  def update
    if @recipe.update(recipe_params)
      redirect_to @recipe, notice: "Succefully updated Recipe"
    else
      render 'edit'
    end
  end

  def destroy
    @recipe.destroy
    redirect_to root_path, notice: "Succefully deleted Recipe"
  end


  private

  def find_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:title, :description, :image, ingredients_attributes: [:id, :name, :destroy],
    directions_attributes: [:id, :step, :destroy])
  end

end
