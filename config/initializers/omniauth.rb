Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, '98f59ab96483b1296cea', '838200bfe64d436842888f2f8e26256141b97810'
end
