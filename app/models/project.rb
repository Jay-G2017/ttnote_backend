class Project < ApplicationRecord
  belongs_to :user
  belongs_to :category, optional: true
  has_many :titles, dependent: :destroy
  has_many :todos, dependent: :destroy
end
