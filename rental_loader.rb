# rental_loader.rb
require_relative 'rental'

class RentalLoader
  def initialize
    @rentals = []
  end

  def load_rentals(data, books, people)
    # Load rental data from JSON and create Rental objects
    data.each do |rental_data|
      book = books.find { |b| b.title == rental_data['book']['title'] }
      person = people.find { |p| p.id == rental_data['person']['id'] }
      rental = Rental.new(rental_data['date'], book, person)
      @rentals << rental
    end
    @rentals
  end

  # Add any other methods related to loading rentals here
end
