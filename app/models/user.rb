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
  has_many :tomatoes

  def today_tomatoes
    self.tomatoes.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
  end

  def today_tomato_size
    today_tomatoes.count
  end

  private
  def create_user_setting
    self.create_user_setting!
  end
end
