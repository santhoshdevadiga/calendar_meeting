class ScheduledMeeting < ApplicationRecord
  belongs_to :employee
  belongs_to :meeting
end
