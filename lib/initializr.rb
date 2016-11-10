module Initializr

  def self.instantiate obj, schemas
    if schemas.is_a? Hash
      children = schemas.keys.map do |key|
        value = schemas[key].instantiate(obj[key])
        Hash[key, value]
      end.reduce({}, &:merge)
      obj.merge(children)
    else
      schemas.instantiate(obj)
    end
  end

end
