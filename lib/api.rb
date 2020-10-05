# handles get requests
class API

  def self.fetch_breweries(state)
    url = "https://api.openbrewerydb.org/breweries?by_state=#{state}"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    breweries = JSON.parse(response)
    breweries.each do |br|
      Brewery.new(name: br["name"], brewery_id: br["id"], state: state)
    end
  end

   def self.get_brewery_details(brewery)
    url = "https://api.openbrewerydb.org/breweries/#{brewery.brewery_id}" # not sure if this is going to work by id...maybe by type: micro, regional, brewpub, large, planning, bar, contract, proprietor
    uri = URI(url)
    response = Net::HTTP.get(uri)
    brew = JSON.parse(response)
    binding.pry
  end
end
