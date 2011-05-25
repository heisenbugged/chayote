require 'rubygems'
require 'spork'

# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'

Spork.prefork do

  if Spork.using_spork?
    Spork.trap_class_method(Rails::Mongoid, :load_models)
  end

  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'remarkable/active_model'
  require 'remarkable/mongoid'

  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.
  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

  RSpec.configure do |config|
    # == Mock Framework
    #
    # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
    #
    # config.mock_with :mocha
    # config.mock_with :flexmock
    # config.mock_with :rspec
    config.mock_with :rr

    config.include Devise::TestHelpers, :type => :controller

    config.before(:suite) do
      DatabaseCleaner.orm = :mongoid
      DatabaseCleaner.strategy = :truncation
      DatabaseCleaner.clean
    end

    config.before(:each) do
      DatabaseCleaner.start
    end

    config.after(:each) do
      DatabaseCleaner.clean
    end
  end
end
Spork.each_run do
  require 'fabrication'

  if Spork.using_spork?
    #load File.join(Rails.root, "app", "models", "user.rb")
  end
end