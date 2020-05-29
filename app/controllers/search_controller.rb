class SearchController < ApplicationController
  def search_events
    if params[:term]
      paginate Event.search_by_title_or_location(query), per_page: 15
      return
    end

    if params[:date]
      paginate Event.search_by_date, per_page: 15
    end
  end

  private 
  def query
    params[:term] || params[:date]
  end
end