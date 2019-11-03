class Todo < ApplicationRecord
  belongs_to :project
  belongs_to :title, optional: true
  has_many :tomatoes, dependent: :destroy
end
