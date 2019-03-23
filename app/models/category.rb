class Category < ApplicationRecord
  belongs_to :event
  validates_presence_of :name
  validates_uniqueness_of :name
end
