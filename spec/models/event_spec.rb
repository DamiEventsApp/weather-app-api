require 'rails_helper'

RSpec.describe Event, type: :model do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:date) }
  it { should belong_to(:user) }
end 