$:.unshift File.expand_path 'lib'
require 'bnmapi/version'
require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

require 'rdoc/task'

EXCLUDES = %w[
  lib/data/*
  lib/error/*
  lib/http/*
]

RDoc::Task.new do |rdoc|
  rdoc.main = 'README.rdoc'
  rdoc.title = "rdoc #{BnmAPI::VERSION} Documentation"
  rdoc.rdoc_files = FileList.new %w[lib/**/*.rb *.rdoc] - EXCLUDES
end
