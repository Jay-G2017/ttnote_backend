class Tomato < ApplicationRecord
  belongs_to :todo
  belongs_to :user

  after_commit :touch_project

  private
  def touch_project
    self.todo.project.touch
  end
end
