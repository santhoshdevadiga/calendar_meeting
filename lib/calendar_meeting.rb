class MeetingRoomOccupiedError < StandardError
end

class MeetingRoomDoesNotExistsError < StandardError
end

class InvalidDateOrDateRageError < StandardError
end


class EmployeeDoesNotExistsError < StandardError
end

module CalndarMeeting
  def self.meeting_room_validation(opts)
    Meeting.where("meeting_room_id = ? and ((start_datetime BETWEEN ? AND ?) OR (end_datetime BETWEEN ? AND ?)) ", opts[:meeting_room_id], opts[:start_datetime].to_datetime, opts[:end_datetime].to_datetime, opts[:start_datetime].to_datetime, opts[:end_datetime].to_datetime)
  end

  def self.date_validation(opts)
    begin
      opts[:start_datetime].to_datetime < opts[:end_datetime].to_datetime
    rescue ExceptionName
      raise InvalidDateOrDateRageError
    end
  end

  def self.employees_validation(employee_ids)
    raise EmployeeDoesNotExistsError if !employee_ids.present?
    employee_ids.each do |emp_no|
      emp = Employee.exists?(emp_no)
      raise EmployeeDoesNotExistsError if !emp
    end
  end

  def self.params_validation(opts)
    date_validation(opts)
    employees_validation(opts[:employee_ids])
  end

  def self.validation(opts)
    params_validation(opts)
    meeting_room = MeetingRoom.find_by_id(opts[:meeting_room_id])
    if meeting_room.present?
      meeting_room = meeting_room_validation(opts)
      if meeting_room.present?
        raise MeetingRoomOccupiedError
      else
        return true
      end
    else
      raise MeetingRoomDoesNotExistsError
    end
    return false
  end

  def self.create_meeting(opts)
    employee_ids = opts[:employee_ids]
    mutex = Mutex.new
    meeting = nil
    mutex.synchronize do
      meeting_room = meeting_room_validation(opts)
      raise MeetingRoomOccupiedError if meeting_room.present?
      meeting = Meeting.create(
        meeting_room_id: opts[:meeting_room_id],
        start_datetime: opts[:start_datetime].to_datetime,
        end_datetime: opts[:end_datetime].to_datetime
      )
      employee_ids.each do |emp_no|
        emp = Employee.find_by_id(emp_no)
        if emp.present?
          meeting.employees << emp
        end
      end
      meeting.save
    end
    return meeting
  end

end
