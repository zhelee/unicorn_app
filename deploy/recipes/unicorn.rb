namespace :unicorn do
  task :setup do
    update_script
    run "#{sudo} update-rc.d -f unicorn_#{application} defaults"
  end

  task :update_init_script do
    run "#{sudo} mkdir -p #{shared_path}/config"
    template "unicorn.erb", "#{shared_path}/config/unicorn.rb"
    template "unicorn.init.erb", "/tmp/unicorn_#{application}"
    run "chmod +x /tmp/unicorn_#{application}"
    run "#{sudo} mv /tmp/unicorn_#{application} /etc/init.d/unicorn_#{application}"
  end

  task :update_conf do
    template "unicorn.conf.erb", "/tmp/#{application}.conf"
    run "#{sudo} mkdir -p /etc/unicorn"
    run "#{sudo} mv /tmp/#{application}.conf /etc/unicorn/#{application}.conf"
  end

  %w{start stop restart}.each do |state|
    desc "unicron #{state}"
    task state do
      "#{sudo} service unicorn_#{application} #{state}"
    end
  end
end

after "deploy:setup", "unicorn:setup"
after "deploy:restart", "unicorn:restart"
