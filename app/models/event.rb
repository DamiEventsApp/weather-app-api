class Event < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search_by_title_or_date, against: [:title, :date]
  validates :title, :date, presence: true
  belongs_to :user
end
