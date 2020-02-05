class TodoSerializer < BaseSerializer
  attributes :id, :name, :title_id, :done

  # 避免N+1查询
  lazy_has_many :tomatoes

  # def tomatoes
  #   _tomatoes = object.load_tomatoes_lazily
  #   ActiveModelSerializers::SerializableResource.new(_tomatoes).as_json
  # end

  # def starred
  #   object.load_today_todo_lazily do |today|
  #    'jay'
  #   end
  # end
end
