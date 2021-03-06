# user interaction

class CLI

  def start
    welcome_message
    prompt_state
    prompt_options
    input = gets.chomp.downcase
    while input != 'exit' do # make sure there are no dup objects
      if input == 'list'
        print_breweries(Brewery.find_by_state(@state))
      elsif input.to_i > 0 && input.to_i <= Brewery.find_by_state(@state).length
        brewery = Brewery.find_by_state(@state)[input.to_i - 1]
        API.get_brewery_details(brewery)
        print_brewery(brewery) # displays brewery info
      else
        puts "invalid input" # change message before submitting
      end
      prompt_options # allows user to have options after getting details
      input = gets.chomp.downcase # fixed infinite loop
    end
    farewell_message
  end

  def print_breweries(br)
    puts ""
    puts "Here is a list of the breweries we found in #{@state.split.map(&:capitalize).join(' ')}." # capitalizes 1st letter of each word for @state; ex: new york = New York
    puts ""
    br.each_with_index do |b, i|
      puts "#{i+1}. #{b.name}"
    end
  end

  def print_brewery(brewery) # come back and add color
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
    puts "--------------------------------------------------"
    puts "By phone: #{brewery.phone}" # find method to split hash to make phone number xxx-xxx-xxxx & if no brewery.phone - display message
    puts ""
    puts "Webpage: #{brewery.website_url}" # if no brewery.website_url - display message
    puts ""
  end # after displaying details, the user is asked to type a number for brewery details - REMOVE option

  def prompt_state
    puts "           Search for breweries by state."
    puts ""
    @state = gets.chomp.downcase
    API.fetch_breweries(@state)
    breweries = Brewery.all
    print_breweries(breweries)
  end

  def prompt_options
    puts ""
    puts "Type in a number to see more details" # doesn't need to show after displaying details, unless user returns to 'list' first
    puts "OR type 'state' to search breweries in a different state" # displays list again, needs to prompt for state selection
    puts "OR type 'list' to see the brewery list again" # needs to show AFTER details
    puts "OR type 'exit' to exit." # functioning properly
    puts ""
  end

  def welcome_message
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
  end # come back and add color

  def farewell_message
    puts ""
    puts "Cheers! \u{1f37b}" # beer emoji 🍻
  end
end