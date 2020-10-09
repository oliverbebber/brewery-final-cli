# handles get requests
class API

  def self.fetch_breweries(state)
    url = "https://api.openbrewerydb.org/breweries?by_state=#{state}"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    breweries = JSON.parse(response)
    breweries.each do |br|
      # binding.pry
      Brewery.new(name: br["name"], brewery_id: br["id"], state: state)
    end
  end

  def self.get_brewery_details(brewery)
    url = "https://api.openbrewerydb.org/breweries/#{brewery.brewery_id}"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    brew = JSON.parse(response)
    # binding.pry
    brewery.brewery_type = brew["brewery_type"]
    brewery.city = brew["city"]
    brewery.street = brew["street"]
    brewery.postal_code = brew["postal_code"]
    brewery.phone = brew["phone"]
    brewery.website_url = brew["website_url"]
  end
end
