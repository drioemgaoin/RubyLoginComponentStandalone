namespace :assets do
  task :precompile do
    Rake::Task['assets:precompile'].invoke
  end
end
