class TitlePolicy < ApplicationPolicy
  attr_reader :user, :title

  def initialize(user, title)
    @user = user
    @title = title
  end

  def update?
    title.project.user == user
  end

  def destroy?
    update?
  end
end