class Tomato < ApplicationRecord
  belongs_to :todo, optional: true
  belongs_to :user
  belongs_to :project, optional: true

  after_commit :touch_project

  private
  def touch_project
    self.project.touch
  end
end
