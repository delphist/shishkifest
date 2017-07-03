# config valid only for current version of Capistrano
lock '3.8.2'

set :application, 'shishkifest'
set :repo_url, 'git@github.com:delphist/shishkifest.git'

set :rvm_type, :system
set :rvm_ruby_version, "#{File.read('.ruby-version').strip}@#{fetch :stage}"

append :linked_files, 'config/database.yml'
append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system', 'public/uploads'

set :migration_role, :app
set :keep_releases, 5

after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :restart do
    invoke 'unicorn:restart'
  end
end
