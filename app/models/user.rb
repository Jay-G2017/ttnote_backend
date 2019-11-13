class User < ApplicationRecord
  after_create :create_user_setting
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable,
         :jwt_authenticatable, jwt_revocation_strategy: JWTBlacklist

  has_many :categories
  has_many :projects
  has_one :user_setting

  private
  def create_user_setting
    self.create_user_setting!
  end
end
