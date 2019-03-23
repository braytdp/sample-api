FactoryBot.define do
  factory :category do
    name
    event_id { create(:event).id }
  end
end
