class User < ApplicationRecord
  after_create :create_user_setting, :create_welcome_template
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable,
         :jwt_authenticatable, jwt_revocation_strategy: JWTBlacklist

  has_many :categories
  has_many :projects
  has_one :user_setting
  has_many :tomatoes
  has_many :today_todos

  def today_tomatoes
    self.tomatoes.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
  end

  def today_tomato_size
    today_tomatoes.count
  end

  def clear_finished_today_todos
    redis = REDIS
    finished_todo_ids = today_todos.where(done: true).pluck(:id)
    finished_todo_ids.each do |todo_id|
      redis.lrem(redis_today_todo_ids_key, 0, todo_id)
    end
  end

  def redis_today_todo_ids_key
    "today_todos:#{self.id}:todo_ids"
  end

  def redis_today_todo_ids
    REDIS.lrange(redis_today_todo_ids_key, 0, -1)
  end

  def today_todos
    Todo.where(id: redis_today_todo_ids)
  end

  private
  def create_user_setting
    self.create_user_setting!
  end

  def create_welcome_template
    new_category = Category.new({name: '工作'})
    new_category.user = self
    new_category.save!

    desc = "亲爱的, #{self.email.split('@').first}\n欢迎使用蕃茄时光！\n\n你可以点击下方的按钮来创建任务或者任务组。\n点击播放按钮会开始一个蕃茄。\n\n蕃茄快乐！"
    new_project = Project.new({name: '欢迎使用蕃茄时光', desc: desc})
    new_project.category = new_category
    new_project.user = self
    new_project.save!

    todo = new_project.todos.build({name: '开始一个蕃茄'})
    todo.title_id = -1
    todo.save!
  end
end
