FactoryGirl.define do
  factory :client do
    name { Faker::Name.name }
  end

  trait :invalid do
    name nil
  end
end

