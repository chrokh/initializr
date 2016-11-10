module Initializr
  class Default

    def initialize schema, default
      @schema = schema
      @default = default
    end

    def instantiate obj
      if !obj.nil?
        @schema.instantiate obj
      else
        @default
      end
    end

  end
end
