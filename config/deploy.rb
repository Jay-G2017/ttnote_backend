# config valid for current version and patch releases of Capistrano
lock "~> 3.12.0"

set :application, "ttnote_backend"
set :repo_url, "git@github.com:Jay-G2017/ttnote_backend.git"
# set :rvm_type, :user
set :rbenv_type, :user # or :system, or :fullstaq (for Fullstaq Ruby), 
set :rbenv_ruby, '2.6.3' # depends on your rbenv setup
# set :rvm_ruby_version, '2.4.6'

# set :rbenv_path, '/usr'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} /usr/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails puma}
set :rbenv_roles, :all # default value

append :linked_files, "config/database.yml", "config/master.key"
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure
