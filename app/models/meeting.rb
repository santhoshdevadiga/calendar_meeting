class Meeting < ApplicationRecord
  has_many :scheduled_meetings, dependent: :destroy
  has_many :employees, through: :scheduled_meetings
  belongs_to :meeting_room
end
