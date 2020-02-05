class ApplicationController < ActionController::API
  include ActionController::MimeResponds
  include Pundit
  respond_to :json
  before_action :authenticate_user!

  def redis_today_todo_ids_key
    "today_todos:#{current_user.id}:todo_ids"
  end

  def redis_today_todo_ids
    REDIS.lrange(redis_today_todo_ids_key, 0, -1)
  end
end
