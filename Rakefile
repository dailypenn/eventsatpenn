# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks

# Disable RSpec verbosity
# See http://bit.ly/MoOoB3
if defined? RSpec
  task(:spec).clear
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.verbose = false
  end
end

namespace :db do
  desc 'Drops, creates, and migrates the database'
  task :clobber do
    Rake::Task['db:drop'].invoke
    Rake::Task['db:create'].invoke
    Rake::Task['db:migrate'].invoke
  end
end

desc "Ailas for `rake spec`"
task :test do
  Rake::Task["spec"].execute
end

namespace :test do
  namespace :db do
    desc "Sets up test database: drops, loads schema, migrates and seeds the test db"
    task :setup do
      Rails.env = ENV['RAILS_ENV'] = 'test'
      Rake::Task['db:drop'].invoke
      Rake::Task['db:create'].invoke
      # Rake::Task['db:seed:load'].invoke
      ActiveRecord::Base.establish_connection
      Rake::Task['db:migrate'].invoke
    end
  end
end
