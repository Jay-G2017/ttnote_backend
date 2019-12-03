class TodoSerializer < ActiveModel::Serializer
  attributes :id, :name, :title_id
  has_many :tomatoes
end
