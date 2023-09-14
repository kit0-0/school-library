require_relative 'rental'

class RentalLoader
  def initialize
    @rentals = []
  end

  def load_rentals(data, books, people)
    data.each do |rental_data|
      book = books.find { |b| b.title == rental_data['book']['title'] }
      person = people.find { |p| p.id == rental_data['person']['id'] }
      rental = Rental.new(rental_data['date'], book, person)
      @rentals << rental
    end
    @rentals
  end
end
