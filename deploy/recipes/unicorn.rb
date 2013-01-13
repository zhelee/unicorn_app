namespace :unicorn do
  task :setup do
    template "unicorn.erb", "#{shared_path}/config/unicorn.rb"
    template "unicorn.init.erb", "/etc/init.d/unicorn_#{application}"
    run "#{sudo} update-rc.d -f unicorn_#{application} defaults"
  end
  %w{start stop restart}.each do |state|
    task state do
      "#{sudo} service unicorn #{state}"
    end
  end
end

after "deploy:setup", "unicorn:setup"
after "deploy:restart", "unicorn:restart"
