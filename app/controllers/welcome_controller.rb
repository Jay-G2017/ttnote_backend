class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!,  only: :index
  def index
    render json: {hello_from: 'ttnote😂'}
  end

  def try_authenticate
    render json: {login: 'success'}
  end
end
