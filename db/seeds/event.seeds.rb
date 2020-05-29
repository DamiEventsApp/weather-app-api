require 'faker'

user = User.create!(name: "John Doe", email: "john@doe.com", password: "guestuser")

40.times do |times|
    params = { 
      title: Faker::Book.title ,
      date: Faker::Time.forward(days: times).to_i,
      user: user
    }
    Event.create!(params)
end