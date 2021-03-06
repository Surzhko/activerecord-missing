module ActiveRecord
  module Missing
    class ForeignKeys
      def self.call
        new.call
      end

      def initialize
        check_missing
      end

      def call
        filtered_tables.inject({}) do |missing_keys, table|
          potential = potential_foreign_keys(table)
          existing = connection.foreign_keys(table).map(&:column)
          missing = potential - existing
          missing_keys[table] = missing if missing.any?
          missing_keys
        end
      end

      private

      def potential_foreign_keys(table)
        columns = connection.columns(table)
        columns.select do |c|
          select_column? table, c, columns.map(&:name)
        end.map(&:name)
      end

      def select_column?(table, column, all_columns)
        return false if ignore_data[table] && ignore_data[table].include?(column.name)
        return false unless column.name.ends_with? "_id"
        return false unless column.type == :integer
        return false if all_columns.include? column.name.sub("_id", "_type")
        true
      end

      def ignore_tables
        ignore_data.map { |k, v| k if v == "all" }.compact
      end

      def filtered_tables
        connection.tables - ignore_tables
      end

      def connection
        ActiveRecord::Missing.connection
      end

      def config
        ActiveRecord::Missing.configuration.foreign_keys_config
      end

      def ignore_data
        config.ignore_data
      end

      def check_missing
        ignore_data.each do |table, columns|
          raise TableNotFoundError, "Table #{table} not found" if connection.tables.exclude?(table)
          next if columns == "all"
          columns.each do |c|
            column_names = connection.columns(table).map(&:name)
            unless column_names.include?(c)
              raise ColumnNotFoundError, "Column '#{c}' in table #{table} not found"
            end
          end
        end
      end
    end
  end
end
