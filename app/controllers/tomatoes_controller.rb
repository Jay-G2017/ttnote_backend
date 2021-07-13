class TomatoesController < ApplicationController
  def index
    project = Project.find params[:id]
    authorize project, :show?
    tomatoes = project.tomatoes
    
    render json: tomatoes
  end


  def create
    todo = Todo.find params[:todo_id]
    authorize todo, :update?
    tomato = todo.tomatoes.build(tomato_params)
    tomato.user = current_user
    tomato.save!

    render json: tomato
  end

  def new_create
    project = Project.find params[:project_id]
    authorize project, :update?
    tomato = project.tomatoes.build(tomato_params)
    tomato.user = current_user
    tomato.save!

    render json: tomato
  end

  def update
    tomato = Tomato.find params[:id]
    authorize tomato.project, :update?
    tomato.update!(tomato_params)

    render json: tomato
  end

  def destroy
    tomato = Tomato.find params[:id]
    authorize tomato.todo, :destroy?
    tomato.destroy!

    render json: {success: true}
  end

  def today_tomato_count
    size = current_user.today_tomato_size

    render json: {size: size}
  end

  private
  def tomato_params
    params.require(:tomato).permit(:minutes, :desc, :status, :node_id)
  end
end
