Gem::Specification.new do |s|
  s.name        = 'initializr'
  s.version     = '0.1.0'
  s.summary     = "Initialize object graph from deeply nested hash based on a schema"
  s.authors     = ["Christopher Okhravi"]
  s.files       = [
    "lib/initializr/array_of.rb",
    "lib/initializr/default.rb",
    "lib/initializr/hash_of.rb",
    "lib/initializr.rb",
    "lib/initializr/schema.rb",
  ]
  s.homepage    = 'https://github.com/chrokh/initializr'
  s.license     = 'MIT'
end
