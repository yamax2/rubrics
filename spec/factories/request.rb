FactoryGirl.define do
  factory :request do
    title { Faker::StarWars.character }
    body  { Faker::StarWars.quote }
    client
  end
end
