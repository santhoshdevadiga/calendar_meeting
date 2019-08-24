class CreateScheduledMeetings < ActiveRecord::Migration[5.2]
  def change
    create_table :scheduled_meetings do |t|
      t.references :employee, foreign_key: true
      t.references :meeting, foreign_key: true
      t.boolean :is_accepted

      t.timestamps
    end
  end
end
