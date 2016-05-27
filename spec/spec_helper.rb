require "rspec/its"
require "rspec/collection_matchers"
require "codeclimate-test-reporter"
require "active_record"
CodeClimate::TestReporter.start

$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "activerecord-missing"
Dir.glob(ActiveRecord::Missing.root.join("spec", "support", "**", "*.rb")).each { |f| require f }
