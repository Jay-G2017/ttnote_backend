class Todo < ApplicationRecord
  belongs_to :project, touch: true
  belongs_to :title, optional: true
  has_many :tomatoes, dependent: :destroy

  after_destroy :remove_redis_today_todos_id

  def load_tomatoes_lazily
    BatchLoader.for(self.id).batch(default_value: []) do |todo_ids, loader|
      Tomato.where(todo_id: todo_ids).each do |tomato|
        loader.call(tomato.todo_id) { |memo| memo << tomato }
      end
    end
  end

  private
  def remove_redis_today_todos_id
    user = self.project.user
    todo_ids_key = user.redis_today_todo_ids_key
    redis = REDIS
    redis.lrem(todo_ids_key, 0, self.id)
  end
end
