class Event < ApplicationRecord
  validates :title, :date, presence: true
  belongs_to :user
end
