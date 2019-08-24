class Meeting < ApplicationRecord
  has_many :scheduled_meetings
  has_many :meetings, through: :scheduled_meetings
  belongs_to :meeting_room
end
