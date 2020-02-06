class ProjectsController < ApplicationController
  def index
    if params[:category_id].to_i == -1
      projects = current_user.projects.where(category_id: -1).updated_desc
    elsif params[:category_id] == 'tagged'
      todo_ids = redis_today_todo_ids
      tomatoes_count = Tomato.where(todo_id: todo_ids).count
      today_project = {id: 'todayProject', name: '今日任务', desc: '已完成的任务会在零点过后移除', tomatoesCount: tomatoes_count}

      projects = [today_project]
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
    if project_id == 'todayProject'
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
    today_todo_ids = redis_today_todo_ids
    if params[:v1]
      result = ActiveModelSerializers::SerializableResource.new(
          project, {include: 'todos.tomatoes,titles', serializer: ProjectV1Serializer, key_transform: :camel_lower}
      ).as_json
      todos_hash = Hash[result[:todos].map do |todo|
        todo['starred'] = today_todo_ids.include?(todo[:id].to_s)
        [todo[:id], todo]
      end
      ]
      titles_hash = Hash[result[:titles].map{ |title| [title[:id], title]}]

      result[:todos] = todos_hash
      result[:titleIds] = result[:titles].map{ |title| title[:id]}
      result[:titles] = titles_hash
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
    result = {id: 'todayProject'}
    todo_ids = redis_today_todo_ids
    todos = Todo.where(id: todo_ids)

    title_todo_ids = {}
    todo_ids.uniq.each do |todo_id|
      todo = todos.find{ |todo| todo.id == todo_id.to_i }
      if title_todo_ids[todo.title_id].nil?
        title_todo_ids[todo.title_id] = [todo.id]
      else
        title_todo_ids[todo.title_id] << todo.id
      end
    end

    title_ids = title_todo_ids.keys
    untitled_todo_ids = todos.select{|todo| todo.title_id == -1}.map(&:id)
    todos_json = ActiveModelSerializers::SerializableResource.new(
        todos, {include: 'tomatoes'}
    ).as_json
    todos_hash = Hash[todos_json.map{ |todo| [todo[:id], todo]}]

    titles = Title.where(id: title_ids)
    titles_json = titles.map{ |title| {id: title.id, name: title.name, todoIds: title_todo_ids[title.id]}}
    title_hash = Hash[titles_json.map{ |title| [title[:id], title]}]

    result[:todos] = todos_hash
    result[:titles] = title_hash
    result[:titleIds] = title_ids
    result[:todoIds] = untitled_todo_ids

    render json: result.to_json
  end
end
