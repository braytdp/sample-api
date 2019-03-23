class User < ApplicationRecord
  has_many :visits
  has_many :interests

  validates_presence_of :name, :identification

  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }
end
