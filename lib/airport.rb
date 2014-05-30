class Airport

	DEFAULT_CAPACITY = 6

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
		planes << plane
		plane.landed!
	end

	def gives_take_off_permission_to(plane)
		plane.take_off!
	end


end