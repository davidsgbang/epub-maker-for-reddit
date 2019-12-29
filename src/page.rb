require 'erb'

class Page
    attr_reader :title, :comment
    def initialize(title, content)
        @title = title
        @content = content
        @template = File.read('./resources/page.erb')
    end

    def render
        ERB.new(@template).result(binding)
    end
end