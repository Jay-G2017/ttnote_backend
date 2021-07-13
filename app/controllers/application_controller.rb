class ApplicationController < ActionController::API
  include ActionController::MimeResponds
  include Pundit
  respond_to :json
  before_action :authenticate_user!

  def turn_array_to_hash(arr, key)
    result = {}
    arr.each do |item|
      if result[item[key]].present? 
        result[item[key]].push(item) 
      else
        result[item[key]] = [] 
        result[item[key]].push(item) 
      end
    end
    result
  end

  def turn_json(arr, serializer)
    ActiveModelSerializers::SerializableResource.new(
      arr, each_serializer: serializer, include: '').as_json
  end

end
