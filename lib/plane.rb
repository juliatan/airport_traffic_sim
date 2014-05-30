class Plane

	def initialize
		take_off!
	end

	def flying?
		@flying
	end

	def take_off!
		@flying = true
		self
	end

	def landed!
		@flying = false
		self
	end

end