class Brewery
  attr_accessor :name, :brewery_id, :state, :city, :street, :postal_code, :website_url

  @@all = []
  
  def initialize(name:, brewery_id:, state:)
    @name = name
    @brewery_id = brewery_id
    @state = state
    @@all << self
  end
  
  def self.all
    @@all
  end
  
  def self.find_by_state(state)
    @@all.select { |br| br.state == state }
  end

end