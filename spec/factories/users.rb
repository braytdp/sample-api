FactoryBot.define do
  factory :user do
    name { Faker::Lorem.word }
    identification { Faker::Number.number(11).to_s }
    active { true }
  end
end
