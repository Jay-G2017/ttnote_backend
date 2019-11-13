class UserSerializer < ActiveModel::Serializer
  attributes :email, :user_setting
  has_one :user_setting
end
