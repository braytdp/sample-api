require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:visits) }
  it { should have_many(:interests) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:identification) }
end
