class EventsController < ApplicationController
  def index
    events = Event.all

    json_response(events)
  end
  
  def show
    event = Event.find(params[:id])

    json_response(event)
  end

  def create
    event = Event.create!(event_params)

    json_response(event, :created)
  end

  def event_params
    params.permit(:name)
  end
end
