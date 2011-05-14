# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "foreign_key_migrations/version"

Gem::Specification.new do |s|
  s.name        = "aspgems-foreign_key_migrations"
  s.version     = ForeignKeyMigrations::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Michał Łomnicki", "Paco Guzmán"]
  s.email       = ["michal.lomnicki@gmail.com", "fjguzman@aspgems.com"]
  s.homepage    = "https://github.com/aspgems/foreign_key_migrations"
  s.summary     = "Automatically generate foreign-key constraints when creating tables"
  s.description = "Automatic Foreign Key automatically generates foreign-key \
constraints when creating tables or adding columns. It uses SQL-92 syntax and as such should be compatible with most databases that support foreign-key constraints."

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency("aspgems-redhillonrails_core", "~> 2.0.0.beta2")
      
  s.add_development_dependency("rspec", "~> 2.5.0")
  s.add_development_dependency("pg")
  s.add_development_dependency("mysql")
  s.add_development_dependency("mysql2")
end

