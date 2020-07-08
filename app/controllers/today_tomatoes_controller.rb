class TodayTomatoesController < ApplicationController
  def index
    # params 'data' => '2020-7-01'
    # find tomatoes
    todo_ids = Tomato.where(user_id: current_user.id).where({created_at: Date.today.beginning_of_day..Date.today.end_of_day }).pluck(:todo_id)
    project_ids = Todo.where(id: todo_ids).pluck(:project_id)
    projects = Project.where(id: project_ids)
    projects = projects.map do |p|
      p['titles'] = [1,2]
    end
    render json: {projects: projects}
  end
end
