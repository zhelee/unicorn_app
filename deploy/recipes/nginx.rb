namespace :nginx do
  task :setup do
    template "nginx.conf.erb", "/etc/nginx/sites-enabled/unicorn_app.conf"
  end
  %w{start stop restart}.each do |state|
    task state do
      run "#{sudo} service nginx #{state}"
    end
  end
end

after "deploy:setup", "nginx:setup"
