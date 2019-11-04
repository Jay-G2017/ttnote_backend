class TitlesController < ApplicationController
  def create
    project = Project.find params[:project_id]
    authorize project, :show?
    title = project.titles.build(title_params)
    title.save!

    render json: title, include: ''
  end

  def update
    title = Title.find params[:id]
    authorize title, :update?
    title.update!(title_params)

    render json: title, include: ''
  end

  def destroy
    title = Title.find params[:id]
    authorize title, :destroy?
    title.destroy!

    render json: {success: true}
  end

  private
  def title_params
    params.require(:title).permit(:name)
  end
end
