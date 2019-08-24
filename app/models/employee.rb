class Employee < ApplicationRecord
  has_many :scheduled_meetings, dependent: :destroy
  has_many :meetings, through: :scheduled_meetings
  validates :name, presence: true
end
