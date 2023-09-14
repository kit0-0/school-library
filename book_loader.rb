# book_loader.rb
require_relative 'book'

class BookLoader
  def initialize
    @books = []
  end

  def load_books(data)
    # Load book data from JSON and create Book objects
    data.each do |book_data|
      @books << Book.new(book_data['title'], book_data['author'])
    end
    @books
  end

  # Add any other methods related to loading books here
end
