class WelcomeController < ApplicationController
  def index
    render json: {hello_from: 'ttnote'}
  end
end
