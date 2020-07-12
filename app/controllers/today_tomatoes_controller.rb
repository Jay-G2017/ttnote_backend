class TodayTomatoesController < ApplicationController
  def index
    # params 'date' => '2020-7-01' 年， 月， 日
    # 目标格式
  #   [
  #     {
  #         "id": 49,
  #         "name": "新建项目",
  #         "desc": "this is good",
  #         "createdAt": "2020-01-02T15:17:24.000+08:00",
  #         "updatedAt": "2020-07-12T10:33:51.000+08:00",
  #         "todos": [
  #             {
  #                 "id": 403,
  #                 "name": "New Thin",
  #                 "titleId": -1,
  #                 "done": false,
  #                 "projectId": 49,
  #                 "tomatoes": [
  #                     {
  #                         "id": 1305,
  #                         "minutes": 0,
  #                         "todoId": 403,
  #                         "desc": null,
  #                         "createdAt": "2020-07-12T10:33:40.000+08:00",
  #                         "updatedAt": "2020-07-12T10:33:40.000+08:00"
  #                     }
  #                 ]
  #             }
  #         ],
  #         "titles": [
  #             {
  #                 "id": 69,
  #                 "name": "Good",
  #                 "projectId": 49,
  #                 "todos": [
  #                     {
  #                         "id": 763,
  #                         "name": "thanks",
  #                         "titleId": 69,
  #                         "done": false,
  #                         "projectId": 49,
  #                         "tomatoes": [
  #                             {
  #                                 "id": 1306,
  #                                 "minutes": 0,
  #                                 "todoId": 763,
  #                                 "desc": null,
  #                                 "createdAt": "2020-07-12T10:33:51.000+08:00",
  #                                 "updatedAt": "2020-07-12T10:33:51.000+08:00"
  #                             }
  #                         ]
  #                     }
  #                 ]
  #             }
  #         ]
  #     }
  # ]

    if params['date'].present?
      arr = params['date'].split('-').map{|item| item.to_i}
      date = Date.new(*arr)
    else
      date = Date.today
    end

    tomatoes = Tomato.where(user_id: current_user.id).where({created_at: date.beginning_of_day..date.end_of_day })
    tomatoes_json = turn_json(tomatoes, Simple::TomatoSerializer) 

    # todo tomato映射
    todo_tomato_hash = turn_array_to_hash(tomatoes_json, :todoId) 

    todo_ids = tomatoes.map{|tomato| tomato.todo_id}
    todos = Todo.where(id: todo_ids)
    # 把tomato拼到todo json里
    todos_json = turn_json(todos, Simple::TodoSerializer).map do |todo_json|
      todo_json['tomatoes'] = todo_tomato_hash[todo_json[:id]]
      todo_json
    end

    # title todo映射
    title_todo_hash = turn_array_to_hash(todos_json, :titleId)

    # 处理未分组todo
    untitle_todos_json = todos_json.select{|todo| todo[:titleId] == -1} 
    project_todo_hash = turn_array_to_hash(untitle_todos_json, :projectId)

    title_ids = todos.map(&:title_id)
    titles = Title.where(id: title_ids)
    # 把todos拼到title json里
    titles_json = turn_json(titles, Simple::TitleSerializer).map do |title_json|
      title_json['todos'] = title_todo_hash[title_json[:id]]
      title_json
    end

    # project title映射
    project_title_hash = turn_array_to_hash(titles_json, :projectId)

    project_ids = todos.map(&:project_id)
    projects = Project.where(id: project_ids)
    projects_json = turn_json(projects, Simple::ProjectSerializer)
    projects_json.each do |project_json|
      project_json['todos'] = project_todo_hash[project_json[:id]] 
      project_json['titles'] = project_title_hash[project_json[:id]] 
    end

    render json: projects_json.to_json
  end
end
