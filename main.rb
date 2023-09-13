require_relative 'app'

def main
  app = App.new
  app.load_data
  loop do
    app.display_options
    app.choose_option
    puts "\n"
  end
end

main
