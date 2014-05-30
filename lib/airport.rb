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

	def planes
		@planes ||= []
	end

	def full?
		planes_count == capacity
	end

	def planes_count
		planes.count
	end

	def gives_landing_permission_to(plane)
		raise "Stormy conditions, you are not allowed to land!" if stormy?
		raise "Airport is full, no entry" if full?
		planes << plane
		plane.landed!
	end

	def gives_take_off_permission_to(plane)
		raise "Stormy conditions, you can't take off!" if stormy? 
		plane.take_off!
	end


end