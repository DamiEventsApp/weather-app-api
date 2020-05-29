FactoryBot.define do
  factory :event do
    user
    title { Faker::Book.title }
    date { Faker::Date.forward(days: 12) }
  end
end