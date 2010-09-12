require 'rake'
require 'rake/testtask'
require 'active_record'
require 'yaml'
require 'logger'

task :default => ['db:drop', 'db:migrate', :test]

desc "Run unit tests"
Rake::TestTask.new do |test|
   test.ruby_opts  << "-w"  # .should == true triggers a lot of warnings
   test.libs       << "test"
   test.test_files =  Dir[ "test/unit/*_test.rb" ]
   test.verbose    =  false
end

namespace :db do
desc "Migrate the database"
task :migrate => :environment do
  
  ActiveRecord::Migrator.migrate('db/migrate', ENV["VERSION"] ? ENV["VERSION"].to_i : nil )
end

desc "Drop the database"
task :drop do
  `rm db/test.sqlite3`
end

task :rollback => :environment do
  ActiveRecord::Migrator.rollback('db/migrate')
end

end

task :environment do
  dbconfig = YAML::load(File.open('config/database.yml'))
  ActiveRecord::Base.establish_connection(dbconfig)
  ActiveRecord::Base.logger = Logger.new(File.open('database.log', 'a'))
end
  
