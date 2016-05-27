require "active_record/missing/version"
require "active_record/missing/foreign_keys"
require "active_record/missing/exceptions"
require "active_record/missing/railtie" if defined?(Rails)
require "active_support/all"

module ActiveRecord
  module Missing
    class << self
      def connection
        ActiveRecord::Base.connection
      end

      def root
        @root ||= Pathname.new File.expand_path("../../..", __FILE__)
      end
    end
  end
end
