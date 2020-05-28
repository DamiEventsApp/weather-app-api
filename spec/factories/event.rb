FactoryBot.define do
  factory :event do
    user
    title { Faker::Book.title }
    date { Time.now.to_i }
  end
end