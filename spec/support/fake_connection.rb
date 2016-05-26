class FakeConnection
  class Column
    attr_reader :name, :type

    def initialize(name, type = nil)
      @name = name
      @type = type
    end

    def column
      @name
    end
  end

  attr_reader :data

  def initialize(data)
    @data = data
  end

  def tables
    data.keys
  end

  def columns(table)
    data[table]["columns"].map { |name, type| Column.new name, type }
  end

  def foreign_keys(table)
    data[table]["fk"].map { |name| Column.new name }
  end
end
