class TodosController < ApplicationController
  def create
    project = Project.find params[:project_id]
    authorize project, :show?
    if params[:title_id].to_i == -1
      todo = project.todos.build(todo_params)
      todo.title_id = -1
    else
      title = Title.find params[:title_id]
      todo = title.todos.build(todo_params)
      todo.project_id = title.project_id
    end

    todo.save!

    render json: todo
  end

  def update
    todo = Todo.find params[:id]
    authorize todo, :update?
    todo.update!(todo_params)

    render json: todo
  end

  def destroy
    todo = Todo.find params[:id]
    authorize todo, :destroy?

    todo.destroy!

    render json: {success: true}
  end

  def tag_today_todo
    todo_id = params[:id]
    todo = Todo.find params[:id]
    authorize todo, :update?
    redis = REDIS
    starred = params[:starred]
    todo_ids_key = redis_today_todo_ids_key

    if starred
      redis.rpush(todo_ids_key, todo_id)
    else
      redis.lrem(todo_ids_key, 0, todo_id)
    end

    render json: {success: true}.to_json
  end

  private
  def todo_params
    params.require(:todo).permit(:name, :done)
  end
end
