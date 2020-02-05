class TodayTodo < ApplicationRecord
  belongs_to :user
  belongs_to :todo
  validates :todo_id, uniqueness: true
end
