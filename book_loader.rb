require_relative 'book'

class BookLoader
  def initialize
    @books = []
  end

  def load_books(data)
    data.each do |book_data|
      @books << Book.new(book_data['title'], book_data['author'])
    end
    @books
  end
end
