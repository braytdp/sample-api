FactoryBot.define do
  sequence :name do |n|
    "#{Faker::Lorem.word} #{n}"
  end

  factory :interest do
    name
    user_id { create(:user).id }
  end
end
