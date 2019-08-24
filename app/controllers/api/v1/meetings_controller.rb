class Api::V1::MeetingsController < ApplicationController
  before_action :set_meeting, only: [:show, :update, :destroy]

  # GET /meetings
  def index
    @meetings = Meeting.all

    render json: @meetings
  end

  # GET /meetings/1
  def show
    render json: @meeting
  end

  # POST /meetings
  def create
    begin
      CalndarMeeting.validation(params)
      CalndarMeeting.create_meeting(params)
      render json: {message: "Meeting created"}, status: 200
    rescue MeetingRoomOccupiedError
      render json: {error_message: "Meeting room already occupied"}, status: 404
    rescue MeetingRoomDoesNotExistsError
      render json: {error_message: "Meeting room does not exists"}, status: 404
    rescue InvalidDateOrDateRageError
      render json: {error_message: "Invalid date or date range"}, status: 404
    rescue EmployeeDoesNotExistsError
      render json: {error_message: "Some of Employee does not exists in employee list"}, status: 404
    rescue Exception => e
      render json: {error: "Internal Server error : #{e.message}"}, status: 500
    end
  end

  # PATCH/PUT /meetings/1
  def update
    puts meeting_params
    if @meeting.update(meeting_params)
      render json: @meeting
    else
      render json: @meeting.errors, status: :unprocessable_entity
    end
  end

  # DELETE /meetings/1
  def destroy
    @meeting.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meeting
      @meeting = Meeting.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def meeting_params
      params.require(:meeting).permit(:meeting_room, :meeting_room_id, :is_occupied, :start_datetime, :end_datetime)
    end
end
