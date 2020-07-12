class CreateDailyNotes < ActiveRecord::Migration[5.2]
  def change
    create_table :daily_notes do |t|
      t.text :desc
      t.references :user, index: true, foreign_key: true
      t.timestamps
    end
  end
end
