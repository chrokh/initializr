module Initializr
  class ArrayOf

    def initialize schema
      @schema = schema
    end

    def instantiate objs
      Array(objs).map { |obj| @schema.instantiate(obj) }
    end

  end
end
