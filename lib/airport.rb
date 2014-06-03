require_relative 'weather'
require_relative 'errors'

class Airport

	DEFAULT_CAPACITY = 6

	include Weather

	attr_accessor(:capacity)

	def initialize(options = {})
		self.capacity = options.fetch(:capacity, capacity)
		# same as self.capacity=(options.fetch(:capacity, capacity))
	end

	def capacity
		@capacity ||= DEFAULT_CAPACITY
	end

	# replaced with attr_accessor(:capacity)
	# def capacity=(value)
	# 	@capacity = value
	# end

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
		if plane.flying? == false
			return nil
		else
			hangar << plane
			plane.landed!
		end
	end

	def gives_take_off_permission_to(plane)
		raise StormyWeatherError.new if stormy? 
		hangar.delete(plane)
		plane.take_off!
	end

end