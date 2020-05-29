class Event < ApplicationRecord
  scope :fresh, -> { order(date: :desc) }
  scope :today, -> {
    where("date = ?", Date.today.to_s)
  }

  include PgSearch::Model
  pg_search_scope :search_by_title_or_location, against: [:title, :location]
  pg_search_scope :search_by_date, against: [:date]
  validates :title, :date, :location, presence: true
  belongs_to :user
  
end
