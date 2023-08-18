require_relative 'nameable'

class Person < Nameable
  attr_reader :id, :name, :age

  def initialize(age, name = 'Unknown', parent_permission: true)
    super
    @id = id
    @name = name
    @age = age
    @parent_permission = parent_permission
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
end
