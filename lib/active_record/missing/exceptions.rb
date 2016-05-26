module ActiveRecord
  module Missing
    class TableNotFoundError < StandardError; end
    class ColumnNotFoundError < StandardError; end
  end
end
