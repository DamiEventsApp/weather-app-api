class SearchController < ApplicationController
  def search_events
    paginate Event.search_by_title_or_date(query), per_page: 15
  end

  private 
  def query
    params[:search_term]
  end
end