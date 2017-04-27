require 'bundler/setup'
Bundler.setup

require_relative '../lib/transifex'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir[File.expand_path(File.join(File.dirname(__FILE__), 'support', '**', '*.rb'))].each { |f| require f }

require "webmock/rspec"
require "vcr"

VCR.configure do |c|
  c.configure_rspec_metadata!
  c.cassette_library_dir = "spec/cassettes"
  c.default_cassette_options = {record: :once}
  c.hook_into :webmock
end

RSpec.configure do |config|
  config.before(:all) do
    reset_transifex_configuration
  end

  config.after(:suite) do # or :each or :all
    File.delete("fetched.yml") if File.exists?("fetched.yml")
  end

  config.include ContentHelper
  config.include ClientHelper
end
