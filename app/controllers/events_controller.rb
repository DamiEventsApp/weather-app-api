class EventsController < ApplicationController
  before_action :set_event, only: %i[ update destroy ]

  def index
    paginate Event.all, per_page: 15
  end

  def create
    event = Event.create!(event_params)  
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
    @event = Event.find_by!(id: params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :date)
  end
end