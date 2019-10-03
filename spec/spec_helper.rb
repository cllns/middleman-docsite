# frozen_string_literal: true

require 'bundler/setup'
require 'byebug'

require 'middleman/docsite'

SPEC_ROOT = Pathname(__dir__)
FIXTURES = SPEC_ROOT.join('fixtures')

Middleman::Docsite.configure do |config|
  config.root = FIXTURES.join('test-site').realpath
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before(:each) do
    FileUtils.rm_r(Dir[Middleman::Docsite.projects_dir.join('*')])
  end

  config.after(:each) do
    FileUtils.rm_r(Dir[Middleman::Docsite.projects_dir.join('*')])
    FileUtils.rm_r(Dir[Middleman::Docsite.source_dir.join('*')])
  end
end
