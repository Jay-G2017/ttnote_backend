class Title < ApplicationRecord
  belongs_to :project, touch: true
  has_many :todos, dependent: :destroy
end
