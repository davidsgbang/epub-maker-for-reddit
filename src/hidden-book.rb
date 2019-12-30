require_relative 'book'
class HiddenBook < Book
    def initialize(post, path)
        super(post, path)
    end

    def render
        book = GEPUB::Book.new
        title = get_title

        book.primary_identifier(title, @id, @cover.url)

        book.add_title(title, title_type: GEPUB::TITLE_TYPE::MAIN)
        book.add_creator(@cover.author)
        
        book.ordered do 
            content_page = book.add_item('page.html')
            content_page.add_content StringIO.new(@content.render)
        end
        
        book.generate_epub(@path)
    end

    def get_title
        posted_date = @post.created_at.strftime("%Y/%m/%d")
        return "Reddit Post by #{@post.author} - #{posted_date}"
    end
end