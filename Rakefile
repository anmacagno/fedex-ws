# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'

RSpec::Core::RakeTask.new(:rspec) do |task|
  task.fail_on_error = false
end

RuboCop::RakeTask.new(:rubocop) do |task|
  task.fail_on_error = false
end

task default: %i[rspec rubocop]
