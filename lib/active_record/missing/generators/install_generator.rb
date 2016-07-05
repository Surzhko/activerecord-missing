require "rails/generators/active_record"

module ActiveRecord
  module Missing
    module Generators
      class InstallGenerator < Rails::Generators::Base
        source_root File.expand_path("../templates", __FILE__)

        desc "Creates an initializer file at config/initializers"

        def create_initializer_file
          copy_file "activerecord_missing.rb.erb", "config/initializers/activerecord_missing.rb"
        end
      end
    end
  end
end
