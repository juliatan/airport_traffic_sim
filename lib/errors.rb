class StormyWeatherError < RuntimeError
	def initialize(message = "The weather is too stormy!")
		super
	end
end

class FullAirportError < RuntimeError
	def initialize(message = "The airport is full. Continue circling.")
		super
	end
end
