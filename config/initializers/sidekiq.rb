# -*- encoding : utf-8 -*-

require 'sidekiq/web'

Sidekiq::Web.use( Rack::Auth::Basic ) do |user, password|
  user == APP_CONFIG[:sidekiq]['user'] && password == APP_CONFIG[:sidekiq]['password']
end
