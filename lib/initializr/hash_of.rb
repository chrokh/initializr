module Initializr
  class HashOf

    def initialize schema
      @schema = schema
    end

    def instantiate obj
      obj.keys.map do |key|
        Hash[key, @schema.instantiate(obj[key])]
      end.reduce({}, &:merge)
    end

  end
end
