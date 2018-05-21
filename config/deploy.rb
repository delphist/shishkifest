# config valid only for current version of Capistrano
lock '3.8.2'

set :application, 'shishkifest'
set :repo_url, 'git@github.com:delphist/shishkifest.git'
set :user, 'deploy'

set :rbenv_type, :user
set :rbenv_ruby, '2.4.2'

append :linked_files, 'config/database.yml', 'config/application.yml'
append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system', 'public/uploads'

set :migration_role, :app
set :keep_releases, 5
