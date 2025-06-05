# spec/spec_helper.rb

RSpec.configure do |config|
  # Enable the use of transactional fixtures
  config.use_transactional_fixtures = true

  # Include FactoryBot methods
  config.include FactoryBot::Syntax::Methods

  # Configure RSpec to use the specified formatter
  config.default_formatter = 'doc' if config.files_to_run.one?

  # Enable colored output
  config.color = true

  # Set the output format for documentation
  config.formatter = :documentation

  # Configure RSpec to run all examples in random order
  config.order = :random

  # Seed random number generator for reproducible test order
  Kernel.srand config.seed
end