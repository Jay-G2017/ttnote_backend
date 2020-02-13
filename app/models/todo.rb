class Todo < ApplicationRecord
  belongs_to :project, touch: true
  belongs_to :title, optional: true
  has_many :tomatoes, dependent: :destroy
  has_one :today_todo

  after_destroy :remove_redis_today_todos_id

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

  private
  def remove_redis_today_todos_id
    user_id = self.project.user_id
    todo_ids_key = "today_todos:#{user_id}:todo_ids"
    redis = REDIS
    redis.lrem(todo_ids_key, 0, self.id)
  end
end
