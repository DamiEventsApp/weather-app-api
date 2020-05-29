FactoryBot.define do
  factory :event do
    user
    title { Faker::Book.title }
    date { 3.days.from_now.to_i }
  end
end