require_relative '../person'
require_relative '../student'
require_relative '../classroom'

RSpec.describe Classroom do
  let(:classroom) { Classroom.new('Math 101') }

  describe '#initialize' do
    it 'creates a Classroom object with the provided label' do
      expect(classroom.label).to eq('Math 101')
    end

    it 'initializes students as an empty array' do
      expect(classroom.students).to be_empty
    end
  end

  describe '#add_student' do
    it 'adds a student to the classroom' do
      student = Student.new(16, 'Alice')
      classroom.add_student(student)

      expect(classroom.students).to include(student)
    end

    it 'sets the classroom for the added student' do
      student = Student.new(16, 'Alice')
      classroom.add_student(student)

      expect(student.classroom).to eq(classroom)
    end
  end
end
