class TodoSerializer < BaseSerializer
  attributes :id, :name, :title_id, :done

  # 避免N+1查询
  lazy_has_many :tomatoes
end
