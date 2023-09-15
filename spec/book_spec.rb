require_relative '../book'

describe Book do
  before :each do
    @book = Book.new 'Title', 'Author'
  end
  it 'throws an argumentError when given less than 2 arguments' do
    expect { Book.new 'title' }.to raise_error(ArgumentError)
  end
  describe '#title' do
    it 'should return title' do
      expect(@book.title).to eql 'Title'
    end
  end
  describe '#author' do
    it 'should return author' do
      expect(@book.author).to eql 'Author'
    end
  end
  describe '#add_rental' do
    it 'should return empty array' do
      expect(@book.rentals).to be_empty
    end
  end
end