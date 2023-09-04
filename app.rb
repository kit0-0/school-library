require_relative 'book'
require_relative 'person'
require_relative 'rental'
require_relative 'student'
require_relative 'teacher'

class App
  MENU_OPTIONS = {
    '1' => :list_books,
    '2' => :list_people,
    '3' => :create_person,
    '4' => :create_book,
    '5' => :create_rental,
    '6' => :list_all_rentals,
    '7' => :exit_program
  }.freeze

  def initialize
    @books = []
    @rentals = []
    @people = []
  end

  def start
    loop { choose_option }
  end

  def list_books
    if @books.empty?
      puts 'No books available. Please add some books and try again.'
    else
      puts "There are #{@books.count} book(s) available."
      @books.each_with_index do |book, index|
        puts "#{index + 1}) Title: \"#{book.title}\" | Author: #{book.author}"
      end
    end
  end

  def list_people
    if @people.empty?
      puts 'No people added yet. Please add a person and try again.'
    else
      @people.each_with_index do |person, index|
        puts "#{index + 1}) [#{person.class}] Name: #{person.name} | Age: #{person.age} | ID: #{person.id}"
      end
    end
  end

  def create_person
    print 'Would you like to create a student (1) or a teacher (2)? Select a number: '
    choice = gets.chomp
    print 'Name: '
    name = gets.chomp
    print 'Age: '
    age = gets.chomp.to_i

    case choice
    when '1'
      create_student(name, age)
    when '2'
      create_teacher(name, age)
    else
      puts 'Invalid choice. Please try again.'
    end
  end

  def create_student(name, age)
    print 'Grade: '
    grade = gets.chomp
    print 'Parent permission? [Y/N]: '
    permission_option = gets.chomp.downcase
    student = Student.new(grade, name, age, parent_permission: permission_option == 'y')
    @people << student
    puts "Student created successfully. ID is #{student.id}"
  end

  def create_teacher(name, age)
    print 'Specialization: '
    specialization = gets.chomp
    teacher = Teacher.new(specialization, name, age)
    @people << teacher
    puts "Teacher created successfully. Teacher ID is #{teacher.id}"
  end

  def create_book
    print 'Title: '
    title = gets.chomp
    print 'Author: '
    author = gets.chomp

    if title.strip != '' && author.strip != ''
      book = Book.new(title, author)
      @books << book
      puts 'Book created successfully.'
    else
      puts 'Please enter the book title and author.'
    end
  end

  def create_rental
    if @books.empty? || @people.empty?
      puts 'Nothing to see here.'
    else
      puts 'Enter the number of the book you want: '
      list_books
      book_number = gets.chomp.to_i - 1
      puts 'Enter your ID: '
      list_people
      person_id = gets.chomp.to_i
      individual = @people.find { |person| person.id == person_id }

      print 'Enter the date [yyyy-mm-dd]: '
      date = gets.chomp.to_s
      rental = Rental.new(date, @books[book_number], individual)
      @rentals << rental
      puts 'Book rented successfully.'
    end
  end

  def list_all_rentals
    if @rentals.empty?
      puts 'No rentals available at the moment.'
    else
      print 'To view your rentals, enter your ID: '
      id = gets.chomp.to_i
      rental = @rentals.select { |rend| rend.person.id == id }

      if rental.empty?
        puts 'No records for that ID.'
      else
        puts 'Here are your records:'
        puts ''
        rental.each_with_index do |record, index|
          puts "#{index + 1}| Date: #{record.date} | Borrower: #{record.person.name} | " \
               "Status: #{record.person.class} | Borrowed book: \"#{record.book.title}\" by #{record.book.author}"
        end
      end
    end
  end

  def choose_option
    puts 'Please choose an option by selecting a number:'
    MENU_OPTIONS.each { |key, value| puts "#{key}. #{value.to_s.tr('_', ' ')}" }

    option = gets.chomp

    if MENU_OPTIONS.include?(option)
      send(MENU_OPTIONS[option])
    else
      puts 'Invalid input. Try again.'
    end
  end

  def exit_program
    puts 'Thank you for using the app.'
    exit!
  end
end
