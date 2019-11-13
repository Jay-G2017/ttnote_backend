class TomatoSerializer < ActiveModel::Serializer
  attributes :id, :minutes, :todo_id, :desc, :created_at, :updated_at
end
