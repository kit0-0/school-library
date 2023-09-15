require_relative 'person_loader'
require_relative 'book_loader'
require_relative 'rental_loader'
require_relative 'json_persistence'
require 'json'

class App
  def initialize
    @people_loader = PersonLoader.new
    @book_loader = BookLoader.new
    @rental_loader = RentalLoader.new
    @people = []
    @books = []
    @rentals = []
  end

  def load_data
    people_data = JSON.parse(File.read('people.json'))
    book_data = JSON.parse(File.read('books.json'))
    rentals_data = JSON.parse(File.read('rentals.json'))

    @people = @people_loader.load_people(people_data)
    @books = @book_loader.load_books(book_data)
    @rentals = @rental_loader.load_rentals(rentals_data, @books, @people)
  end

  def display_options
    puts 'Welcome to the school library app!'
    puts 'Please choose an option by entering a number:'
    puts '1 - List all books'
    puts '2 - List all people'
    puts '3 - Create a person'
    puts '4 - Create a book'
    puts '5 - Create a rental'
    puts '6 - List all rentals for a given person id'
    puts '7 - Exit'
  end

  def choose_option
    option = gets.chomp
    case option
    when '1' then load_books
    when '2' then load_people
    when '3' then create_person
    when '4' then create_book
    when '5' then create_rental
    when '6' then display_rentals_by_person_id
    when '7'
      save
      puts 'Thank you for using this app!'
      exit
    end
  end

  def save
    save_books
    save_people
    save_rentals
  end

  def save_books
    books_data = @books.map do |book|
      {
        title: book.title,
        author: book.author,
        rentals: book.rentals
      }
    end
    FileWriter.new('books.json').write(books_data)
  end

  def save_people
    people_data = @people.map do |person|
      {
        id: person.id,
        name: person.name,
        age: person.age,
        parent_permission: person.parent_permission,
        type: person.class,
        specialization: person_specialization(person),
        rentals: person.rentals
      }
    end
    FileWriter.new('people.json').write(people_data)
  end

  def person_specialization(person)
    if person.instance_of?(Teacher)
      person.specialization
    else
      'No Specialization'
    end
  end

  def save_rentals
    rentals_data = @rentals.map do |rental|
      {
        date: rental.date,
        book: {
          title: rental.book.title,
          author: rental.book.author,
          rentals: rental.book.rentals
        },
        person: {
          id: rental.person.id,
          name: rental.person.name,
          age: rental.person.age,
          parent_permission: rental.person.parent_permission,
          type: rental.person.class,
          rentals: rental.person.rentals
        }
      }
    end
    FileWriter.new('rentals.json').write(rentals_data)
  end

  def create_person
    puts 'Do you want to create a student (1) or a teacher (2)? [Input the number]: '
    input = gets.chomp
    if %w[1 2].include?(input)
      puts 'Age: '
      age_input = gets.chomp
      puts 'Name: '
      name_input = gets.chomp
    end
    case input
    when '1'
      create_student(age_input, name_input)
    when '2'
      create_teacher(age_input, name_input)
    else
      puts 'Please enter a valid input'
    end
  end

  def create_student(age, name)
    puts 'Has parent permission? [Y/N]'

    permission_input = gets.chomp

    case permission_input.upcase

    when 'Y'

      @people << Student.new(age, name)

      puts 'Person created successfully'

    when 'N'

      @people << Student.new(age, name, parent_permission: false)

      puts 'Person created successfully'

    else

      puts 'Please enter a valid input'

    end
  end

  def create_teacher(age, name)
    puts 'Specialization: '

    specialization = gets.chomp

    @people << Teacher.new(specialization, age, name)

    puts 'Person created successfully!'
  end

  def load_people
    puts 'There is no people yet.' if @people.empty?

    @people.map { |people| people_printer(people) }
  end

  def people_printer(people)
    puts "[#{people.class}] Name: #{people.name}, ID: #{people.id}, Age: #{people.age}"
  end

  def create_book
    puts 'Title: '

    title = gets.chomp

    puts 'Author: '

    author = gets.chomp

    @books << Book.new(title, author)

    puts 'Book created successfully!'
  end

  def load_books
    puts 'There is no books yet.' if @books.empty?

    @books.map { |book| show_books(book) }
  end

  def show_books(book)
    puts "Title: \"#{book.title}\", Author: #{book.author}"
  end

  def create_rental
    return puts 'There is no books yet.' if @books.empty?

    puts 'Select a book from the following list by number'
    @books.map.with_index do |book, idx|
      print "#{idx}) "
      show_books(book)
    end
    book_choice = gets.chomp.to_i
    if book_choice.negative? || book_choice >= @books.length
      puts 'Invalid input! Please enter a number within the range.'

      return

    end

    puts 'Select a person from the following list by number (not id)'

    @people.map.with_index do |people, idx|
      print "#{idx}) "

      people_printer(people)
    end

    people_choice = gets.chomp.to_i

    if people_choice.negative? || people_choice >= @people.length

      puts 'Invalid input! Please enter a number within the range.'

      return

    end

    puts 'Date: '

    date = gets.chomp

    @rentals << Rental.new(date, @books[book_choice], @people[people_choice])

    puts 'Rental created successfully!'
  end

  def display_rentals_by_person_id
    load_people

    puts 'Enter person ID'

    id = gets.chomp.to_i

    puts 'Rentals:'

    filtered_rentals = @rentals.select { |rental| rental.person.id == id }

    if filtered_rentals.empty?

      puts 'This person has no rentals.'

      return

    end

    filtered_rentals.map { |rental| rental_printer(rental) }
  end

  def rental_printer(rental)
    puts "Date: #{rental.date}, Book \"#{rental.book.title}\" by #{rental.book.author}"
  end
end
