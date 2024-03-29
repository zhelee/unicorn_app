namespace :nginx do
  task :setup do
    template "nginx.conf.erb", "/tmp/unicorn_app.conf"
    run "#{sudo} mv /tmp/unicorn_app.conf /etc/nginx/sites-enabled/unicorn_app.conf"
  end
  %w{start stop restart}.each do |state|
    task state do
      run "#{sudo} service nginx #{state}"
    end
  end
end

after "deploy:setup", "nginx:setup"
after "nginx:setup", "nginx:restart"
