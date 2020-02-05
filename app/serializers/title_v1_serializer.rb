class TitleV1Serializer < BaseSerializer
  lazy_relationship :todos
  attributes :id, :name

  # 避免N+1查询
  attribute :todo_ids do
    lazy_todos.map(&:id)
  end
end
