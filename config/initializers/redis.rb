require 'redis'

REDIS = Redis.new(url: Rails.application.credentials[Rails.env.to_sym][:redis_url])
