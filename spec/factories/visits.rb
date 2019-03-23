FactoryBot.define do
  factory :visit do
    user_id { create(:user).id }
    event_id { create(:event).id }
  end
end
