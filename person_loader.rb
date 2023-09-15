# person_loader.rb
require_relative 'person'
require_relative 'student'
require_relative 'teacher'

class PersonLoader
  def initialize
    @people = []
  end

  def load_people(data)
    data.each do |person_data|
      if person_data['type'] == 'Student'
        student = Student.new(person_data['age'], person_data['name'],
                              parent_permission: person_data['parent_permission'])
        student.instance_variable_set(:@id, person_data['id'])
        @people << student
      else
        teacher = Teacher.new(person_data['specialization'], person_data['age'], person_data['name'])
        teacher.instance_variable_set(:@id, person_data['id'])
        @people << teacher
      end
    end
    @people
  end
end
