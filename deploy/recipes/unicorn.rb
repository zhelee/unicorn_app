namespace :unicorn do
  task :setup do
    create_rvm_wrapper
    update_init_script
    update_conf
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
      run "#{sudo} service unicorn_#{application} #{state}"
    end
  end

  desc "create rvm bin wrapper"
  task :create_rvm_wrapper do
    run "rvm wrapper ruby-1.9.3-p327 bootup unicorn_rails && mkdir -p #{shared_path}/bin && mv /usr/local/rvm/bin/bootup_unicorn_rails #{shared_path}/bin"
    link_rvm_wrapper
  end

  task :link_rvm_wrapper do
    run "ln -s #{shared_path}/bin #{current_path}/bin"
  end
end

after "deploy:setup", "unicorn:setup"
before "deploy:restart", "unicorn:link_rvm_wrapper"
after "deploy:restart", "unicorn:restart"
