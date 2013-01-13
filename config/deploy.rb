set :rvm_type, :system
set :rvm_string, "ruby-1.9.3-p327"

require "bundler/capistrano"
require "rvm/capistrano"

set :application, "unicorn_app"
set :deploy_to, "/var/www"
set :deploy_via, :remote_cache

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

set :domain, "192.168.33.10"
server domain, :web, :app, :db, :primary => true
set :user, "vagrant"
set :use_sudo, false

set :scm, :git
set :repository,  "git://github.com/zhelee/unicorn_app.git"
set :branch, :master

after "deploy:restart", "deploy:cleanup"
