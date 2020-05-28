class EventsController < ApplicationController
  skip_before_action :authorize_api_request, only: %i[ index ]
  before_action :set_event, only: %i[ update destroy ]

  def index
    paginate Event.all, per_page: 15
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
    params.require(:event).permit(:title, :date)
  end
end