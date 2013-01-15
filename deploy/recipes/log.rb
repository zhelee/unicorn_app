namespace :log do
  desc "tail rails log files"
  task :rails, :roles => :app do
    run "tail -f #{shared_path}/log/production.log" do |channel, stream, data|
      puts "#{channel[:host]}: #{data}"
      break if stream == :err
    end
  end
  
  desc "tail unicorn out log files"
  task :unicorn, :roles => :app do
    run "tail -f #{shared_path}/log/unicorn_stdout.log" do |channel, stream, data|
      puts "#{channel[:host]}: #{data}"
      break if stream == :err
    end
  end

  desc "tail unicorn out log files"
  task :unicorn_err, :roles => :app do
    run "tail -f #{shared_path}/log/unicorn_stderr.log" do |channel, stream, data|
      puts "#{channel[:host]}: #{data}"
      break if stream == :err
    end
  end

  desc "tail nginx out log files"
  task :nginx, :roles => :web do
    run "tail -f /var/log/nginx/access.log" do |channel, stream, data|
      puts "#{channel[:host]}: #{data}"
      break if stream == :err
    end
  end

  desc "tail nginx out log files"
  task :nginx_err, :roles => :web do
    run "tail -f /var/log/nginx/error.log" do |channel, stream, data|
      puts "#{channel[:host]}: #{data}"
      break if stream == :err
    end
  end
end
