class InterestsController < ApplicationController
  def index
    interests = Interest.all

    json_response(interests)
  end
  
  def show
    interest = Interest.find(params[:id])

    json_response(interest)
  end

  def create
    interest = Interest.create!(interest_params)

    json_response(interest, :created)
  end

  def interest_params
    params.permit(:name, :user_id)
  end
end
