class ChangeTodoIdToTomatoes < ActiveRecord::Migration[5.2]
  def change
    change_column_null :tomatoes, :todo_id, true
  end
end
