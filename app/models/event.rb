class Event < ApplicationRecord
  scope :fresh, -> { order(date: :desc) }
  scope :today, -> {
    where("date > ? AND date < ?", 1.day.ago.to_i, 1.day.from_now.to_i)
  }

  include PgSearch::Model
  pg_search_scope :search_by_title_or_date, against: [:title, :date]
  validates :title, :date, presence: true
  belongs_to :user
end
