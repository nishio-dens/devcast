lock "~> 3.10.0"

set :application, "devcast"
set :repo_url, 'git@github.com:nishio-dens/devcast.git'

set :deploy_to, "/app"
set :pty, true

set :linked_dirs, %w{log tmp public/system public/images}

set :keep_releases, 5

set :rbenv_type, :user
set :rbenv_ruby, '2.4.2'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}

namespace :deploy do
  after :restart, :finishing do
    on roles(:web) do
      invoke! "systemd:puma:reload"
    end
  end
end

namespace :systemd do
  namespace :puma do
    task :start do
      on roles(:web) do
        execute :sudo, :systemctl, :start, :puma
      end
    end

    task :stop do
      on roles(:web) do
        execute :sudo, :systemctl, :stop, :puma
      end
    end

    task :restart do
      on roles(:web) do
        execute :sudo, :systemctl, :restart, :puma
      end
    end

    task :reload do
      on roles(:web) do
        execute :sudo, :systemctl, :reload, :puma
      end
    end
  end
end
