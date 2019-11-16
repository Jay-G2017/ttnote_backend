class UserSettingSerializer < ActiveModel::Serializer
  attributes :tomato_minutes, :short_rest_minutes, :long_rest_minutes, :auto_rest
end
