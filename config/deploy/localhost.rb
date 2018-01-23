set :rails_env, 'production'
set :ssh_options, { port: 8022 }

server 'localhost', user: 'root', roles: %w{app db}

