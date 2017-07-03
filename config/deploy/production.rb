server 'shishkifest.ru',
  roles: %w[app db web],
  ssh_options: {
    user: fetch(:user),
    forward_agent: false,
    auth_methods: %w[publickey]
  }

set :rails_env, 'production'
set :deploy_to, "/home/#{fetch(:user)}/apps/#{fetch(:application)}"
