require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new(:test) do |t|
  t.libs << "specs"
  t.libs << "lib"
  t.test_files = FileList["specs/**/*_spec.rb"]
end

task :default => :test
