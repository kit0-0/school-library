
require_relative '../rental'


RSpec.describe Book do
  let(:date) { Date.new(2023, 9, 15) } 
  let(:book) { double("Book") } 
  let(:person) { double("Person") }

  describe '#initialize' do
    it 'creates a Book object with the provided title and author' do
      expect(book.title).to eq('Book Title')
      expect(book.author).to eq('Author Name')
    end

    it 'initializes rentals as an empty array' do
      expect(book.rentals).to be_empty
    end
  end

describe "adding the rental to the book's rentals" do
  it "adds the rental to the book's rentals" do
    expect(book).to receive(:rentals).and_return([]) 
    expect(book.rentals).to receive(:<<).with(rental) 

    Rental.new(date, book, person)
  end
end

describe "adding the rental to the person's rentals" do
  it "adds the rental to the person's rentals" do
    expect(person).to receive(:rentals).and_return([]) 
    expect(person.rentals).to receive(:<<).with(rental) 

    Rental.new(date, book, person)
  end
end
  

end
