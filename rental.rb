class Rental
  attr_accessor :date, :book, :person

  def initialize(book, person, date)
    @book = book
    @person = person
    @date = date

    book.add_rental(self)
    person.add_rental(self)
  end
end
