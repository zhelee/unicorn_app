desc "tail log files"
task :tail_log, :roles => :app do
  run "tail -f #{shared_path}/log/production.log" do |channel, stream, data|
    puts "#{channel[:host]}: #{data}"
    break if stream == :err
  end
end
