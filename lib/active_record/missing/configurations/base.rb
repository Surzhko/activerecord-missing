require "active_record/missing/configurations/foreign_keys"

module ActiveRecord
  module Missing
    module Configurations
      class Base
        attr_accessor :foreign_keys_config

        def initialize
          @foreign_keys_config = ActiveRecord::Missing::Configurations::ForeignKeys.new
        end

        def foreign_keys
          yield @foreign_keys_config
        end
      end
    end
  end
end
