class AddDateToDailyNotes < ActiveRecord::Migration[5.2]
  def change
    add_column :daily_notes, :date_at, :date
  end
end
