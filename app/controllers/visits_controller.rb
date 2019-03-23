class VisitsController < ApplicationController
  def index
    visits = Visit.all

    json_response(visits)
  end
  
  def show
    visit = Visit.find(params[:id])

    json_response(visit)
  end

  def create
    visit = Visit.create!(visit_params)

    json_response(visit, :created)
  end

  def visit_params
    params.permit(:name, :user_id, :event_id)
  end
end
