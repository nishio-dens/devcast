set :user, "admin"
set :stage, :production
set :rails_env, :production
set :branch, "master"

server "densan-v2", user: "admin", roles: %w{web app db}
