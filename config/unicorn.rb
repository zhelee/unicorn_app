working_directory "/var/www/current"
pid "/var/www/current/tmp/pids/unicorn.pid"
stderr_path "/var/www/current/log/unicorn.log"
stdout_path "/var/www/current/log/unicorn.log"

listen "/tmp/unicorn.unicorn_app.sock"
worker_processes 2
timeout 30
