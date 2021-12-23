FactoryBot.define do

  factory:user do
    name { Faker::Name.name}
    email { Faker::Internet.email}
    password { Faker::Lorem.characters(number:8)}
  end

  factory:post do
    association :user
    title { Faker::Lorem.characters(number:5)}
    body { Faker::Lorem.characters(number:50)}
    rate { Faker::Number.between(from:1, to:5)}
    lat { Faker::Number.between(from:-90, to:90)}
    lng { Faker::Number.between(from:-90, to:90)}
    post_prefecture { Faker::Number.between(from:1, to:48)}
  end

  factory:comment do
    association :user
    association :post
    comment { Faker::Lorem.characters(number:10)}
  end

  factory:room do
    user_id { 1 }
  end

  factory:message do
    association :user
    association :room
    content { Faker::Lorem.characters(number:10)}
  end
end