require_relative '../teacher' 

describe Teacher do
 
  describe "#initialize" do
    it "creates a Teacher object with the correct attributes" do
      teacher = Teacher.new("Math", 30, "John Doe", parent_permission: true)

      expect(teacher.specialization).to eq("Math")
      expect(teacher.age).to eq(30)
      expect(teacher.name).to eq("John Doe")
      expect(teacher.parent_permission).to be(true)
    end
  end


  describe "#can_use_services?" do
    it "returns true" do
      teacher = Teacher.new("Math", 30)

      result = teacher.can_use_services?

      expect(result).to be(true)
    end
  end
end
