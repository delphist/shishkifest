server 'shishkifest.ru',
  roles: %w[app db web],
  ssh_options: {
    user: 'deployer',
    forward_agent: false,
    auth_methods: %w[publickey]
  }

set :rails_env, 'production'
set :deploy_to, '/var/www/shishkifest'
