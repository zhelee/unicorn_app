set :rvm_type, :system
set :rvm_string, "ruby-1.9.3-p327"

require "bundler/capistrano"
require "rvm/capistrano"

load "deploy/recipes/base"
load "deploy/recipes/nginx"
load "deploy/recipes/unicorn"

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
