class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :name, :desc, :created_at, :updated_at, :tomatoes_count
  has_many :todos
  has_many :titles

  def todos
    object.todos.where(title_id: -1)
  end

  def tomatoes_count
    Tomato.where(todo_id: object.todo_ids).count
  end
end
