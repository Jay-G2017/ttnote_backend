class TomatoesController < ApplicationController
  def create
    todo = Todo.find params[:todo_id]
    authorize todo, :update?
    tomato = todo.tomatoes.build(tomato_params)
    tomato.save!

    render json: tomato
  end

  def update
    tomato = Tomato.find params[:id]
    authorize tomato.todo, :update?
    tomato.update!(tomato_params)

    render json: tomato
  end

  def destroy
    tomato = Tomato.find params[:id]
    authorize tomato.todo, :destroy?
    tomato.destroy!

    render json: {success: true}
  end

  private
  def tomato_params
    params.require(:tomato).permit(:minutes, :desc)
  end
end
