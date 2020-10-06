# user interaction

class CLI
 
  def start
    puts ""
    puts "      .======================================."
    puts "      |                                      |"
    puts "      |C|||C|||C||| C|||C|||C|||C|||C|||C||| |"
    puts "      | ||| ||| |||  ||| ||| ||| ||| ||| ||| |"
    puts "      '======================================'"
    puts "      Welcome to the ultimate brewery directory"
    puts "                                              "
    puts "           .:.                              "
    puts "          C|||'                            "
    puts "        ___|||______________________________"
    puts "       [____________________________________]"
    puts "        |   ____    ____    ____    ____   | "
    puts "        |  (____)  (____)  (____)  (____)  | "
    puts "        |  |    |  |    |  |    |  |    |  | "
    puts "        |  |____|  |____|  |____|  |____|  | "
    puts "        |  I====I  I====I  I====I  I====I  | "
    puts "        |   |  |    |  |    |  |    |  |   | "
    puts ""
    puts "            Search for breweries by state.   "
    puts ""
    @state = gets.chomp.downcase
    puts ""
    API.fetch_breweries(@state)
    puts ""
    breweries = Brewery.all
    print_brewery(breweries)
    puts ""
    puts "Type in a number to see more details, type 'exit' to leave directory."
    puts ""
    input = gets.chomp.downcase # make sure to add something to allow user to exit - typing in exit states "...a list found in EXIT"
    while input != 'exit' do
      brewery = Brewery.find_by_state(@state)[input.to_i - 1]
      API.get_brewery_details(brewery)
    end
    # binding.pry
  end
  
  def print_brewery(brew)
    puts ""
    puts "Here is a list of the breweries we found in #{@state.upcase}."
    puts ""
    brew.each_with_index do |br, i|
      puts "#{i}. #{br.name}"
    end
  end
end