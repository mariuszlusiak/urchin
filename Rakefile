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


namespace :db do
  desc 'Create YAML test fixtures from data in an existing database.
  Defaults to development database. Set RAILS_ENV to override.'

  task :extract_fixtures => :environment do
    sql = "SELECT * FROM %s"
    skip_tables = ["schema_info", "sessions"]
    ActiveRecord::Base.establish_connection
    tables = ENV['FIXTURES'] ? ENV['FIXTURES'].split(/,/) : ActiveRecord::Base.connection.tables - skip_tables
    tables.each do |table_name|
      i = "000"
      File.open("#{Rails.root}/spec/fixtures/#{table_name}.yml", 'w') do |file|
        data = ActiveRecord::Base.connection.select_all(sql % table_name)
        file.write data.inject({}) { |hash, record|
          hash["#{table_name.singularize}_#{i.succ!}"] = record
          hash
        }.to_yaml
      end
    end
  end
end



