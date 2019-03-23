require 'rails_helper'

RSpec.describe Visit, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:event) }
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:event_id) }
end
