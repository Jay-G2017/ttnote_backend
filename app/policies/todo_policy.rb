class TodoPolicy < ApplicationPolicy
  attr_reader :user, :todo

  def initialize(user, todo)
    @user = user
    @todo = todo
  end

  def update?
   todo.project.user == user
  end

  def destroy?
    update?
  end
end