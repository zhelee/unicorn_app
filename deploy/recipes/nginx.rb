namespace :nginx do
  task :setup do
    template "nginx.conf.erb", "/etc/nginx/sites-enalbed/unicorn_app.conf"
  end
  %{start stop restart}.each do |state|
    task state do
      "#{sudo} service nginx #{state}"
    end
  end
end

after "deploy:setup", "nginx:setup"
