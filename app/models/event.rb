class Event < ApplicationRecord
  has_many :visits
  validates_presence_of :name
end
