FactoryBot.define do
  factory :event do
    title { Faker::Book.title }
    date { Time.now.to_i }
  end
end