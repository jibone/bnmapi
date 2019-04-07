require "bundler/setup"
require "bnmapi"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

# Setup VCR
require 'vcr'
VCR.configure do |config|
  config.cassette_library_dir = 'spec/cassettes'
  config.hook_into :webmock
end

# Setup webmock
if ENV['VCR_RECORD'] != 'true'
  require 'webmock/rspec'
  WebMock.disable_net_connect!(allow_localhost: true)
end
