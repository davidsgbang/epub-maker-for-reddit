require 'gepub'
require_relative 'page'
require_relative 'cover'

class Book
    def initialize(post)
        @id = post.post_id
        @cover = Cover.new(post.title, post.author, post.perma_link)
        @content = Page.new(post.title, post.content)
    end

    def render
        book = GEPUB::Book.new

        book.primary_identifier(@cover.title, @id, @cover.url)

        book.add_title(@cover.title, title_type: GEPUB::TITLE_TYPE::MAIN)
        book.add_creator(@cover.author)
        
        book.ordered do 
            cover_page = book.add_item('cover.html')
            cover_page.add_content StringIO.new(@cover.render)
            content_page = book.add_item('page.html')
            content_page.add_content StringIO.new(@content.render)
        end
        
        book.generate_epub("#{@id}.epub")
    end
end