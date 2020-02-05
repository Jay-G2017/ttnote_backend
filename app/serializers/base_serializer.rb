class BaseSerializer < ActiveModel::Serializer
  include AmsLazyRelationships::Core
end