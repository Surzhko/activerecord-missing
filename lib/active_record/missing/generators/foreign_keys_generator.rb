require "rails/generators/active_record"

module ActiveRecord
  module Missing
    module Generators
      class ForeignKeysGenerator < ActiveRecord::Generators::Base
        source_root File.expand_path("../templates", __FILE__)

        def create_migration_file
          @keys = ActiveRecord::Missing::ForeignKeys.call
          migration_template "foreign_keys.rb.erb", "db/migrate/#{file_name}.rb"
        end
      end
    end
  end
end
