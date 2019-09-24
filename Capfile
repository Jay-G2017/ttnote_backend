require "capistrano/setup"
require "capistrano/deploy"
require "capistrano/scm/git"
install_plugin Capistrano::SCM::Git
require "capistrano/rvm"
require "capistrano/bundler"
require "capistrano/rails/migrations"
require 'capistrano/puma'
install_plugin Capistrano::Puma, load_hooks: false
install_plugin Capistrano::Puma::Workers
install_plugin Capistrano::Puma::Nginx

# Load custom tasks from `lib/capistrano/tasks` if you have any defined
Dir.glob("lib/capistrano/tasks/*.rake").each { |r| import r }
