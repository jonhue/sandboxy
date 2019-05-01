# frozen_string_literal: true

# Configure Rails Envinronment
ENV['RAILS_ENV'] = 'test'

# # Test Coverage
# require 'simplecov'
# SimpleCov.start

require File.expand_path('dummy30/config/environment.rb', __dir__)
require 'rails/test_help'

ActiveRecord::Base.logger = Logger.new File.dirname(__FILE__) + '/debug.log'
ActiveRecord::Migration.verbose = false

load File.dirname(__FILE__) + '/schema.rb'

require 'shoulda'
require 'factory_bot'
FactoryBot.find_definitions
