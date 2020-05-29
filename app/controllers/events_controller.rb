class EventsController < ApplicationController
  skip_before_action :authorize_api_request, only: %i[ index ]
  before_action :set_event, only: %i[ update destroy ]

  def index
    paginate Event.fresh, per_page: 5
  end

  def todays_events
    if params[:today]
      paginate Event.fresh.today, per_page: 5
    end
  end

  def create
    event = @current_user.events.create!(event_params)  
    json_response(event, :created)
  end

  def update
    @event.update(event_params)
    head :no_content
  end

  def destroy
    @event.destroy
    head :no_content
  end

  private

  def set_event
    @event = @current_user.events.find_by!(id: params[:id])
  end

  def event_params
    params.permit(:title, :date, :location)
  end
end