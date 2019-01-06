# frozen_string_literal: true

require 'bundler/setup'
require 'conference_plan'
require 'pry'

RSpec.configure do |config|
end

def fixture_path
  File.expand_path('fixtures', __dir__)
end

def fixture_file(file)
  File.read(fixture_path + '/' + file)
end
