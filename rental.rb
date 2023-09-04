class Rental
  attr_accessor :date, :book, :person

  def initialize(book, person, _date)
    @book = book
    @person = person
    book.rentals << self
    person.rentals << self
  end
end
