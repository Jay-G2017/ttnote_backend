class TitleSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :todos
end
