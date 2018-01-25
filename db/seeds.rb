30.times do |n|
  User.create!(
        name: Faker::Name.first_name,
        email: Faker::Internet.email,
        password: "password",
        age: Faker::Number.between(10, 80),
        sort: Faker::Number.between(1, 2),
        )
end

60.times do |post|
  user_id =  rand(2..30)
  Post.create!(
        title: Faker::Vehicle.vin,
        content: Faker::Vehicle.manufacture,
        user_id: user_id,
        requested_date: Faker::Date.forward,
        )
end
