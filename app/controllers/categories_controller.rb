class CategoriesController < ApplicationController
  after_action :verify_authorized, except: [:index, :create]

  def index
    render json: current_user.categories
  end

  def show
    category = Category.find params[:id]
    authorize category, :show?

    render json: category
  end

  def update
    category = Category.find params[:id]
    authorize category, :update?
    category.update!(category_params)

    render json: category
  end

  def create
    category = Category.new(category_params)
    category.user = current_user
    category.save!

    render json: category
  end

  def destroy
    category = Category.find params[:id]
    category.destroy!

    render json: { success: true }
  end

  private
  def category_params
    params.require(:category).permit(:name)
  end
end
