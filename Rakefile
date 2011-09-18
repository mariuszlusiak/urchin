# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require 'rake'


Urchin::Application.load_tasks


begin
  require 'resque/tasks'
rescue
  STDERR.puts "Run `bundle install` to install resque"
end

begin
  require 'resque_scheduler/tasks'
rescue
  STDERR.puts "Run `bundle install` to install resque-retry"
end

task "resque:setup" => :environment do
  include ActiveRecord
  ENV['QUEUE'] = '*'
  puts 'Loding environment...'
  print ' Done.'
end
task :install => ["db:create","db:migrate"]
task :uninstall => ["db:drop"]
task :reinstall => ["uninstall","install"]
