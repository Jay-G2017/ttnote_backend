class Todo < ApplicationRecord
  belongs_to :project
  belongs_to :title, optional: true
  has_many :tomatoes, dependent: :destroy
  has_one :today_todo

  def load_tomatoes_lazily
    BatchLoader.for(self.id).batch(default_value: []) do |todo_ids, loader|
      Tomato.where(todo_id: todo_ids).each do |tomato|
        loader.call(tomato.todo_id) { |memo| memo << tomato }
      end
    end
  end

  def load_today_todo_lazily
    BatchLoader.for(self.id).batch do |todo_ids, loader|
      TodayTodo.where(todo_id: todo_ids).each do |today_todo|

        today = block_given? ? yield(today_todo) : today_todo

        loader.call(today_todo.todo_id, today)
      end
    end
  end

end
