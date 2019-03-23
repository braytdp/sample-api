class CategoriesController < ApplicationController
  def index
    categories = Category.all

    json_response(categories)
  end
  
  def show
    category = Category.find(params[:id])

    json_response(category)
  end

  def create
    category = Category.create!(category_params)

    json_response(category, :created)
  end

  def category_params
    params.permit(:name, :event_id)
  end
end
