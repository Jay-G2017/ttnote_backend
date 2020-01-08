class TodoSerializer < ActiveModel::Serializer
  attributes :id, :name, :title_id, :done
  has_many :tomatoes
end
