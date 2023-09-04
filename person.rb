require_relative 'nameable'

class Person < Nameable
  attr_reader :id, :name, :age, :rentals
  attr_accessor :classroom

  def initialize(age, name = 'Unknown', parent_permission: true)
    super()
    @id = rand(1_000_000)

    @name = name
    @age = age
    @parent_permission = parent_permission
    @rentals = []
  end

  private

  def of_age?
    @age >= 18
  end

  public

  def can_use_services?
    of_age? || @parent_permission
  end

  def correct_name
    @name
  end

  def add_rental(date, book)
    rental = Rental.new(date, book, self)
    rentals << rental unless rentals.include?(rental)
  end
end
