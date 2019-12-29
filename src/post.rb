require 'redd'
require 'yaml'
require_relative 'book'
require_relative 'hidden-book'

class Post
    attr_reader :title, :post_id, :perma_link, :author, :content, :created_at
    def initialize(post_id, title = nil, nsfw = nil)
        @config = YAML::load_file("./config/config.yaml") unless defined? CONFIG

        @post_id = post_id
        @title = title
        @nsfw = nsfw

        populate_fields!
    end

    def generate_book
        book = Book.new(self)
        if @nsfw
            book = HiddenBook.new(self)
        end

        return book
    end

    private
    def populate_fields!
        begin
            session = create_redd_session
            submission = session.from_ids("t3_#{@post_id}").first
        rescue => exception
            raise "Failed to create reddit session: #{exception.message}"
        end

        raise ArgumentError, "Cannot find Submission with ID [#{@post_id}]" unless !submission.nil?

        @content = submission.selftext_html
        @perma_link = submission.permalink
        @title = submission.title unless !@title.nil?
        @author = submission.author.name
        @nsfw = submission.over_18? unless !@nsfw.nil?
        @created_at = Time.at(submission.created_utc)
    end

    def create_redd_session
        session = Redd.it(
            user_agent: 'script:epub-maker-for-reddit:v.0.1 (by /u/KleenexDevourer)',
            client_id:  @config['client_id'],
            secret:     @config['secret'],
            username:   @config['username'],
            password:   @config['password']
        )
        
        session
    end
end
