module ActiveRecord
  module Missing
    class Base < StandardError; end
    class TableNotFoundError < Base; end
    class ColumnNotFoundError < Base; end
  end
end
