require 'erb'

class Cover
    attr_reader :title, :author, :url
    def initialize(title, author, url)
        @title = title
        @author = author
        @url = url
        @template = File.read('./resources/cover.erb')
    end

    def render
        ERB.new(@template).result(binding)
    end
end