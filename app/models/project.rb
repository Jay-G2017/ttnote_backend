class Project < ApplicationRecord
  belongs_to :user
  belongs_to :category, optional: true
  has_many :titles, dependent: :destroy
  has_many :todos, dependent: :destroy

  scope :created_desc, -> { order(created_at: :desc) }
  scope :updated_desc, -> { order(updated_at: :desc) }
end
