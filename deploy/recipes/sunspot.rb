namespace :sunspot do
  task :reindex do
    run "bundle exec rake sunspot:solr:reindex"
  end

  task :setup do
    run "mkdir -p #{shared_path}/solr"
    run "RAILS_ENV=production bundle exec rake sunspot:solr:start"
    create_solr_link
    reindex
  end

  %w{start stop}.each do |state|
    task state do
      run "bundle exec rake sunspot:solr:#{state}"
    end
  end

  task :create_solr_link do
    run "rm #{previous_release}/solr"
    run "ln -s #{shared_path}/solr #{current_path}/solr"
  end
end

# consider to check whether model has been changed
after "deploy:restart", "sunspot:reindex"
after "deploy:restart", "sunspot:create_solr_link"
