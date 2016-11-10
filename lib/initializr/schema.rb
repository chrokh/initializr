module Initializr
  class Schema

    def initialize klass, schemas = {}
      @klass = klass
      @schemas = schemas
    end

    def instantiate obj
      children = @schemas.keys.map do |key|
        value = @schemas[key].instantiate(obj[key])
        Hash[key, value]
      end.reduce({}, &:merge)

      args = obj.merge(children)

      @klass.new args
    end
  end

end
