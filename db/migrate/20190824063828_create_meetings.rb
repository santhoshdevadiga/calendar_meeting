class CreateMeetings < ActiveRecord::Migration[5.2]
  def change
    create_table :meetings do |t|
      t.references :meeting_room
      t.boolean :is_occupied
      t.datetime :start_datetime
      t.datetime :end_datetime

      t.timestamps
    end
  end
end
