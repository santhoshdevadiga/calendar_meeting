class CreateMeetingRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :meeting_rooms do |t|
      t.string :name

      t.timestamps
    end
  end
end
