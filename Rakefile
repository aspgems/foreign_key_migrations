require 'bundler'
Bundler::GemHelper.install_tasks

require 'rspec/core/rake_task'
%w[postgresql mysql mysql2].each do |adapter|
  namespace adapter do
    RSpec::Core::RakeTask.new(:spec) do |spec|
      spec.rspec_opts = "-Ispec/connections/#{adapter}"
    end
  end
end

task :default => [:create_databases, :spec]

desc 'Run postgresql and mysql tests'
task :spec do
  %w[postgresql mysql mysql2 sqlite3].each do |adapter|
    puts "\n\e[1;33m[#{ENV["BUNDLE_GEMFILE"]}] #{adapter}\e[m\n"
    Rake::Task["#{adapter}:spec"].invoke
  end
end

desc 'Create databases'
task :create_databases do
  %w[postgresql mysql].each do |adapter|
    Rake::Task["#{adapter}:build_databases"].invoke
  end
end

namespace :postgresql do
  desc 'Build the PostgreSQL test databases'
  task :build_databases do
    system "psql -c 'create database foreign_key_migrations;' -U postgres >/dev/null"
    abort "failed to create postgres database" unless $?.success?
  end

  desc 'Drop the PostgreSQL test databases'
  task :drop_databases do
    %x( dropdb foreign_key_migrations )
  end

  desc 'Rebuild the PostgreSQL test databases'
  task :rebuild_databases => [:drop_databases, :build_databases]
end

task :build_postgresql_databases => 'postgresql:build_databases'
task :drop_postgresql_databases => 'postgresql:drop_databases'
task :rebuild_postgresql_databases => 'postgresql:rebuild_databases'

namespace :mysql do
  desc 'Build the MySQL test databases'
  task :build_databases do
    system "mysql -e 'create database foreign_key_migrations default character set utf8 default collate utf8_unicode_ci;' >/dev/null"
    abort "failed to create mysql database" unless $?.success?
  end

  desc 'Drop the MySQL test databases' 
  task :drop_databases do
    %x( mysqladmin -f drop foreign_key_migrations )
  end

  desc 'Rebuild the MySQL test databases'
  task :rebuild_databases => [:drop_databases, :build_databases]
end

task :build_mysql_databases => 'mysql:build_databases'
task :drop_mysql_databases => 'mysql:drop_databases'
task :rebuild_mysql_databases => 'mysql:rebuild_databases'

desc 'clobber generated files'
task :clobber do
  rm_rf "pkg"
  rm_rf "tmp"
  rm    "Gemfile.lock" if File.exist?("Gemfile.lock")
end