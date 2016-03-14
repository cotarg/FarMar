class FarMar::Market

	attr_reader :id, :name

	def initialize(market_hash)
	# ID - (Fixnum) a unique identifier for that market
	# Name - (String) the name of the market (not guaranteed unique)
	# Address - (String) street address of the market
	# City - (String) city in which the market is located
	# County - (String) county in which the market is located
	# State - (String) state in which the market is located
	# Zip - (String) zipcode in which the market is located
	
	@id = market_hash[:id]
	@name = market_hash[:name]
	@address = market_hash[:address]
	@city = market_hash[:city]
	@county = market_hash[:county]
	@state = market_hash[:state]
	@zip_code = market_hash[:zip_code]

	end

	def self.all(path_to_csv)
    id = nil

    market_list = []
    
    # this iterates through the CSV and assigns values to variables to be used in the account initialization.
    CSV.foreach(path_to_csv) do |row|
        id = row[0]
        name = row[1]
        market_hash = {id: id, name: name}
        market_list << self.new(market_hash)
    end
    market_list
	end
end