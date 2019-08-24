class Api::V1::MeetingRoomsController < ApplicationController
  before_action :set_meeting_room, only: [:show, :update, :destroy]

  # GET /meeting_rooms
  def index
    @meeting_rooms = MeetingRoom.all

    render json: @meeting_rooms
  end

  # GET /meeting_rooms/1
  def show
    render json: @meeting_room
  end

  # POST /meeting_rooms
  def create
    @meeting_room = MeetingRoom.new(meeting_room_params)

    if @meeting_room.save
      render json: @meeting_room, status: :created
      # , location: @meeting_room
    else
      render json: @meeting_room.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /meeting_rooms/1
  def update
    if @meeting_room.update(meeting_room_params)
      render json: @meeting_room
    else
      render json: @meeting_room.errors, status: :unprocessable_entity
    end
  end

  # DELETE /meeting_rooms/1
  def destroy
    @meeting_room.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meeting_room
      @meeting_room = MeetingRoom.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def meeting_room_params
      params.require(:meeting_room).permit(:name)
    end
end
