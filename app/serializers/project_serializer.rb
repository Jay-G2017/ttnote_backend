class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :name, :desc
  has_many :todos
  has_many :titles

  def todos
    object.todos.where(title_id: -1)
  end
end
