class MeetingRoom < ApplicationRecord
  has_many :meetings, dependent: :destroy
  validates :name, presence: true
end
