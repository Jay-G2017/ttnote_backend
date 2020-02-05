class ProjectsController < ApplicationController
  def index
    if params[:category_id].to_i == -1
      projects = current_user.projects.where(category_id: -1).updated_desc
    else
      category = Category.find params[:category_id]
      authorize category, :show?
      projects = category.projects.updated_desc
    end

    render json: projects, include: ''
  end

  def all
    render json: current_user.projects.updated_desc, include: ''
  end

  def create
    if params[:category_id].to_i == -1
      project = Project.new(project_params)
      project.category_id = -1
    else
      category = Category.find params[:category_id]
      authorize category, :show?
      project = category.projects.build(project_params)
    end

    project.user = current_user
    project.save!

    render json: project, include: ''
  end

  def show
    project_id = params[:id]
    if project_id == 'today_project'
      render_today_project
    else
      render_normal_project
    end
  end

  def update
    project = Project.find params[:id]
    authorize project, :show?
    project.update!(project_params)

    render json: project, include: ''
  end

  def destroy
    project = Project.find params[:id]
    authorize project, :destroy?
    project.destroy

    render json: {success: true}
  end

  private
  def project_params
    params.require(:project).permit(:name, :desc)
  end

  def render_normal_project
    project = Project.find params[:id]
    authorize project, :show?
    if params[:v1]
      result = ActiveModelSerializers::SerializableResource.new(
          project, {include: 'todos.tomatoes,titles', serializer: ProjectV1Serializer, key_transform: :camel_lower}
      ).as_json
      todos_json = Hash[result[:todos].map{ |todo| [todo[:id], todo] }]
      titles_json = Hash[result[:titles].map{ |title| [title[:id], title]}]

      result[:todos] = todos_json
      result[:titleIds] = result[:titles].map{ |title| title[:id]}
      result[:titles] = titles_json
      render json: result.to_json
    else
      render json: project, include: 'todos.tomatoes,titles.todos.tomatoes'
    end
  end

  def render_today_project
    # 目标结果
    # {
    #     id: 'today_project',
    #     todos: {'1': {id: 1}, '2': {id: 2}},
    #     todo_ids: [],
    #     title_ids: [],
    #     titles: {'1': {id: 1, todo_ids: []}},
    # }
    result = {id: 'today_project'}
    todo_ids = redis_today_todo_ids
    todos = Todo.where(id: todo_ids)
    todos_json = ActiveModelSerializers::SerializableResource.new(
        todos, {include: 'tomatoes'}
    ).as_json
    result[:todos_json] = todos_json

    render json: result.to_json
  end
end
