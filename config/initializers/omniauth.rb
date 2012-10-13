Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, APP_CONFIG[:github]['key'], APP_CONFIG[:github]['secret']
end
