class ProjectsController < ApplicationController
  def index
    if params[:category_id].to_i == -1
      projects = current_user.projects.where(category_id: -1)
    else
      category = Category.find params[:category_id]
      authorize category, :show?
      projects = category.projects
    end

    render json: projects, include: ''
  end

  def all
    render json: current_user.projects, include: ''
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
end
