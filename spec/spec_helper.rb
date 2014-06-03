# Configure Rails Envinronment
ENV["RAILS_ENV"] = "test"
require File.expand_path("../dummy/config/environment.rb",  __FILE__)

require 'rspec/rails'
require 'pry'

ENGINE_RAILS_ROOT=File.join(File.dirname(__FILE__), '../')

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[File.join(ENGINE_RAILS_ROOT, "spec/support/**/*.rb")].each {|f| require f }

RSpec.configure do |config|
  config.use_transactional_fixtures = true
end
# $LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
# $LOAD_PATH.unshift(File.dirname(__FILE__))
#
# require 'rubygems'
# require 'bundler'
# require 'rspec'
# begin
#   Bundler.setup(:default, :development)
# rescue Bundler::BundlerError => e
#   $stderr.puts e.message
#   $stderr.puts 'Run `bundle install` to install missing gems'
#   exit e.status_code
# end
#
# require 'rspec/rails'
# require 'rspec/autorun'
#
# require 'ecircle_soap_api'
#
# # Requires supporting files with custom matchers and macros, etc,
# # in ./support/ and its subdirectories.
# Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}
# I18n.load_path += Dir.glob( File.dirname(__FILE__) + "/../config/locales/*.{rb,yml}" )
#
# RSpec.configure do |config|
# end
