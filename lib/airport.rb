require_relative 'weather'

class Airport

	DEFAULT_CAPACITY = 6

	include Weather

	def initialize(options = {})
		self.capacity = options.fetch(:capacity, capacity)
		# same as self.capacity=(options.fetch(:capacity, capacity))
	end

	def capacity
		@capacity ||= DEFAULT_CAPACITY
	end

	def capacity=(value)
		@capacity = value
	end

	def hangar
		@hangar ||= []
	end

	def full?
		planes_count == capacity
	end

	def planes_count
		hangar.count
	end

	def gives_landing_permission_to(plane)
		raise StormyWeatherError.new if stormy?
		raise FullAirportError.new if full?
		hangar << plane
		plane.landed!
	end

	def gives_take_off_permission_to(plane)
		raise StormyWeatherError.new if stormy? 
		hangar.delete(plane)
		plane.take_off!
	end

end