class CreateUserSettings < ActiveRecord::Migration[5.2]
  def change
    create_table :user_settings do |t|
      t.numeric :tomato_minutes, default: 25, null: false
      t.numeric :short_rest_minutes, default: 5, null: false
      t.numeric :long_rest_minutes, default: 15, null: false
      t.boolean :auto_rest, default: true, null: false
      t.references :user, null: false, index: true, foreign_key: true

      t.timestamps
    end
  end
end
