module ActiveRecord
  module Missing
    class ForeignKeys
      def self.call(ignore_data = {})
        new(ignore_data).call
      end

      attr_reader :ignore_data

      def initialize(ignore_data)
        @ignore_data = ignore_data.inject({}) do |memo,(k,v)|
          memo[k.to_s] = Array(v).map { |a| a.is_a?(String) ? a : a.to_s }
          memo
        end
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
        ignore_data.map { |k,v| k if v.include? "all" }.compact
      end

      def filtered_tables
        connection.tables - ignore_tables
      end

      def connection
        ActiveRecord::Missing.connection
      end

      def check_missing
        ignore_data.each do |k,v|
          raise TableNotFoundError, "Table #{k} not found" unless connection.tables.include?(k)
          connection.columns(k).each do |c|
            unless v.include?("all") || v.include?(c.name)
              raise ColumnNotFoundError, "Column #{c} in table #{k} not found"
            end
          end
        end
      end
    end
  end
end
