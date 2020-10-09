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
    print_breweries(breweries)
    puts ""
    puts "Type in a number to see more details"
    puts "OR type 'state' to search breweries in a different state"
    puts "OR type 'list' to see the brewery list again"
    puts "OR type 'exit' to exit."
    puts ""
    input = gets.chomp.downcase # make sure to add something to allow user to exit - typing in exit states "...a list found in EXIT"
    while input != 'exit' do
      if input == 'list'
        print_breweries(Brewery.find_by_state(@state))
      elsif input.to_i > 0 && input.to_i <= Brewery.find_by_state(@state).length
        brewery = Brewery.find_by_state(@state)[input.to_i - 1]
        API.get_brewery_details(brewery)
        print_brewery(brewery)
      else
        puts "invalid input"
      end
      input = gets.chomp.downcase
    end
    puts ""
    puts "Cheers!" # come back and use beer emoji/ascii for farewell
  end
  
  def print_breweries(br)
    puts ""
    puts "Here is a list of the breweries we found in #{@state.split.map(&:capitalize).join(' ')}." # capitalizes 1st letter of each word for @state; ex: new york = New York
    puts ""
    br.each_with_index do |b, i|
      puts "#{i+1}. #{b.name}"
    end
  end

  def print_brewery(brewery)
    puts ""
    puts "#{brewery.name} details"
    puts "--------------------------------------------------"
    puts "This is a #{brewery.brewery_type} brewery."
    puts "--------------------------------------------------"
    puts "Address:"
    puts ""
    puts "#{brewery.street}" 
    puts "#{brewery.city}, #{brewery.state.split.map(&:capitalize).join(' ')}"
    puts "#{brewery.postal_code}"
    puts "--------------------------------------------------"
    puts "Contact #{brewery.name}"
    "--------------------------------------------------"
    puts "By phone: #{brewery.phone}" # find method to split hash to make phone number xxx-xxx-xxxx
    puts ""
    puts "Webpage: #{brewery.website_url}"
    puts ""
  end
end