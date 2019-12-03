class ProjectV1Serializer < ActiveModel::Serializer
  attributes :id, :name, :desc, :todo_ids
  has_many :todos
  has_many :titles, serializer: TitleV1Serializer

  def todo_ids
    object.todos.where(title_id: -1).select(:id).map(&:id)
  end
end
