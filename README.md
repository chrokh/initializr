# Initializr

Initializes object graph from deeply nested hash based on schema.


# Installation

```bash
gem install initializr
```


# Usage

Assume we have the following hash...

```ruby
hash = {
  posts: [
    {
      title: "Hello world",
      comments: [
        {
          body: "What an amazing post"
        }
      ]
    }
  ]
}
```

And we want to build an object graph using the following classes...

```ruby
class Catalog
  def initialize hash
    @posts = hash[:posts]
  end
end

class Post
  def initialize hash
    @title    = hash[:title]
    @comments = hash[:comments]
  end
end

class Comment
  def initialize hash
    @body = hash[:body]
  end
end
```

Then we simply need to model the schema like this...

```ruby
require 'initializr/array_of'
require 'initializr/hash_of'
require 'initializr/default'
require 'initializr/schema'

comment = Initializr::Schema.new(Comment)
comments = Initializer::ArrayOf.new(comment)
post = Initializr::Schema.new(Post, {
  comments: comments
})
posts = Initializr::ArrayOf.new(post)
catalog = Initializr::Schema.new(catalog, {
  posts: posts
}
```

Which, of course, could more succintly be expressed like this...

```ruby
catalog = Initializr::Schema.new(Catalog, {
  posts: Initializr::ArrayOf.new(Initializr::Schema.new(Post, {
    comments: Initializr::ArrayOf.new(Initializr::Schema.new(Comment))
  }))
})
```

And if the syntax looks cumbersome we could trivially create a few aliases...

```ruby
array_of = Initializr::ArrayOf
hash_of  = Initializr::HashOf
default  = Initializr::Default
schema   = Initializr::Schema
```

And then express the same thing like this instead...

```ruby
catalog = schema.new(Catalog, {
  posts: array_of.new(schema.new(Post, {
    comments: array_of.new(schema.new(Comment))
  }))
})
```

Either way, having designed the schema we can then construct an object graph from our original hash by simply running any of the versions below.

```ruby
catalog.instantiate(hash)
#<Catalog:0x007fbfb78a97a0 @posts=[#<Post:0x007fbfb78a9908 @title="Hello world", @comments=[#<Comment:0x007fbfb78a9a98 @body="What an amazing post">]>]>
```

And if we don't want to build the catalog object we could of course just pass the array of posts instead of the hash containing the posts.

```ruby
catalog.instantiate(hash[:posts])
#[#<Post:0x007fc7381b4a70 @title="Hello world", @comments=[#<Comment:0x007fc7381b4bb0 @body="What an amazing post">]>]
```

But if our hash hash multiple keys and we still don't want to wrap everything into the catalog object we can call the static instantiate function and pass the schema and the hash instead of calling instantiate on a schema. This will instantiate every schema under every key of the hash like this...

```ruby
require 'initializr'
Initializr.instantiate(hash, { posts: catalog })
#{:posts=>[#<Post:0x007fc7381ae0a8 @title="Hello world", @comments=[#<Comment:0x007fc7381ae1e8 @body="What an amazing post">]>]}
```

## Usage with factories

This library assumes that your classes are instantiated with a single hash as an argument. If that isn't true for your case then I suggest that you pass factories that can be used to instantiate your classes rather than passing your classes directly. See below for an example. In fact, this is how I'm using this library myself :)

```ruby
person_hash = { name: "Jane", age: 99 }

class Person
  def initialize name, age
    @name = name
    @age = age
  end
end

class PersonFactory
  def initialize hash
    @name = hash[:name]
    @age  = hash[:age]
  end

  def build
    Person.new(@name, @age)
  end
end

schema  = Initializr::Schema.new(PersonFactory)
factory = schema.instantiate(person_hash)
factory.build
#<Person:0x007fcb610b80b8 @name="Jane", @age=99>
```

# License
The MIT License (MIT)
Copyright (c) 2016 Christopher Okhravi

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

