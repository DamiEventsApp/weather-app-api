require 'faker'

user = User.create!(name: "John Doe", email: "john@doe.com", password: "guestuser")

40.times do |times|
    params = { 
      title: Faker::Book.title ,
      date: Time.now.to_i * (times * times),
      user: user
    }
    Event.create!(params)
end