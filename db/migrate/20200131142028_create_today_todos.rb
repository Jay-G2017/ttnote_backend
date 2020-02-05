class CreateTodayTodos < ActiveRecord::Migration[5.2]
  def change
    create_table :today_todos do |t|
      t.references :user, null: true, index: true, foreign_key: true
      t.references :todo, null: true, index: {unique: true}, foreign_key: true

      t.timestamps
    end
  end
end
