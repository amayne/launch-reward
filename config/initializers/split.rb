Split.redis = REDIS

Split::Dashboard.use Rack::Auth::Basic do |username, password|
  username == 'username' && password == 'password'
end

Split.configure do |config|
  config.experiments = YAML.load_file "config/experiments.yml"
end