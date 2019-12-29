require_relative 'book'
require_relative 'post'

puts "Self-Post only!"
print "Link ID: "
id = gets.strip

begin
    post = Post.new(id)
    book = post.generate_book

    book.render
rescue ArgumentError => argumentException
    puts argumentException.message
rescue => exception
    puts "Cannot create EPUB: #{exception.message}"
end