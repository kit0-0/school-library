require_relative '../book'
require_relative '../person'

RSpec.describe Person do
  let(:person) { Person.new(18, 'John Doe') }

  describe '#initialize' do
    it 'creates a Person object with the provided age and name' do
      expect(person.age).to eq(18)
      expect(person.name).to eq('John Doe')
    end

    it 'sets the name to "Unknown" if no name is provided' do
      person_without_name = Person.new(25)
      expect(person_without_name.name).to eq('Unknown')
    end

    it "generates a random id between 1 and 10,000" do
      ids = []
      1000.times do
        person = Person.new(18, 'John Doe')
        ids << person.id
      end

      expect(ids).to all(be_between(1, 10_000).inclusive)
    end
  
    it 'initializes rentals as an empty array' do
      expect(person.rentals).to be_empty
    end
  end
  describe "#correct_name" do
  it "returns the name of the person" do
    expect(person.send(:correct_name)).to eq('John Doe')
  end
end

describe "#can_use_services?" do
    it "returns true for a person of age 18" do
      person = Person.new(18, 'John Doe')
      expect(person.send(:can_use_services?)).to be true
    end

    it "returns true for a person with parent permission" do
      person = Person.new(16, 'Alice', parent_permission: true)
      expect(person.send(:can_use_services?)).to be true
    end

    it "returns false for a person under 18 without parent permission" do
      person = Person.new(16, 'Bob', parent_permission: false)
      expect(person.send(:can_use_services?)).to be false
    end
  end
  
end
