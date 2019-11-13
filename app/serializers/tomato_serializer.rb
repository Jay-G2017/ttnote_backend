class TomatoSerializer < ActiveModel::Serializer
  attributes :id, :minutes, :todo_id, :desc
end
