module ActiveRecord
  module Missing
    module Configurations
      class ForeignKeys
        attr_accessor :ignore_data

        def initialize
          @ignore_data = {}
        end

        def ignore(table, *columns)
          string_columns = columns.map(&:to_s)
          string_columns = "all" if columns.empty? || string_columns == ["all"]
          string_table = table.to_s
          ignore_data[string_table] = string_columns
        end
      end
    end
  end
end
