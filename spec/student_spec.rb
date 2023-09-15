require_relative '../student'

describe Student do
 
  describe "#initialize" do
    it "creates a Student object with the correct attributes" do
      student = Student.new(16, "Alice", parent_permission: true)

      expect(student.age).to eq(16)
      expect(student.name).to eq("Alice")
      expect(student.parent_permission).to be(true)
    end
  end


  describe "#play_hooky" do
    it "returns the shrug emoticon" do
      student = Student.new(17, "Bob")

      result = student.play_hooky

      expect(result).to eq('¯(ツ)/¯')
    end
  end

  describe "#classroom=" do
  it "sets the classroom and adds the student to it" do
    student = Student.new(15, "Charlie")
    classroom = double("Classroom")
    
    # Stub the students method to return an empty array initially.
    allow(classroom).to receive(:students).and_return([])

    # Expect the push method to be called with the student.
    expect(classroom.students).to receive(:push).with(student)
    
    student.classroom = classroom
    
    expect(student.classroom).to eq(classroom)
  end

  it "does not add the student to the classroom if already present" do
    student = Student.new(14, "David")
    classroom = double("Classroom")
    
    allow(classroom).to receive(:students).and_return([student])
    
    expect(classroom.students).not_to receive(:push)
    
    student.classroom = classroom
    
    expect(student.classroom).to eq(classroom)
  end
end
 
end
