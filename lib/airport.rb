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
		raise "Stormy conditions, you are not allowed to land!" if stormy?
		raise "Airport is full, no entry" if full?
		hangar << plane
		plane.landed!
	end

	def gives_take_off_permission_to(plane)
		raise "Stormy conditions, you can't take off!" if stormy? 
		hangar.delete(plane)
		plane.take_off!
	end


end