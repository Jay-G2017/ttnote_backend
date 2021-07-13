class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!,  only: [:index, :hello]
  def index
    render json: {hello_from: 'ttnote😂'}
  end

  def hello
    render json: {hello: 'world'}
  end

  def try_authenticate
    render json: {login: 'success'}
  end
end
