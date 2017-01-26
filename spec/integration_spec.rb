require 'initializr/array_of'
require 'initializr/hash_of'
require 'initializr/default'
require 'initializr/schema'

describe 'Initializr' do

  let(:array_of) { Initializr::ArrayOf }
  let(:hash_of)  { Initializr::HashOf  }
  let(:default)  { Initializr::Default }
  let(:schema)   { Initializr::Schema  }

  let(:title1) { double :title1 }
  let(:body1) { double :body1 }

  let(:data) {
    {
      posts: [
        {
          title: title1,
          comments: [
            {
              body: body1
            }
        ]
        }
      ]
    }
  }

  it 'initializes' do

    #
    # Define the classes
    #

    class Catalog
      attr_reader :posts
      def initialize hash
        @posts = hash[:posts]
      end
    end

    class Post
      attr_reader :title, :comments
      def initialize hash
        @title    = hash[:title]
        @comments = hash[:comments]
      end
    end

    class Comment
      attr_reader :body
      def initialize hash
        @body = hash[:body]
      end
    end


    #
    # Define the schema
    #

    comment = schema.new(Comment)
    post = schema.new(Post, {
      comments: array_of.new(comment)
    })
    catalog = schema.new(Catalog, {
      posts: array_of.new(post)
    })

    result = catalog.instantiate(data)

    expect(result.posts.length).to eq 1
    expect(result.posts[0].title).to eq title1
    expect(result.posts[0].comments.length).to eq 1
    expect(result.posts[0].comments[0].body).to eq body1

  end

end

