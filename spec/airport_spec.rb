require 'airport'
require 'weather'

# A plane currently in the airport can be requested to take off.
#
# No more planes can be added to the airport, if it's full.
# It is up to you how many planes can land in the airport and how that is impermented.
#
# If the airport is full then no planes can land
describe Airport do
  
  let(:airport) { Airport.new(capacity: 10) }
  
  context 'setting capacity' do

    it 'should allow setting capacity on initializing' do
      expect(airport.capacity).to eq 10 
    end

  end

  context 'taking off and landing' do

    it 'a plane can land in the airport' do
      plane = double :plane, landed!: nil
      airport.gives_landing_permission_to(plane)
      expect(airport.planes_count).to eq 1
    end

    it 'a plane receives landing status when it lands in the airport' do
      plane = double :plane
      expect(plane).to receive(:landed!)
      airport.gives_landing_permission_to(plane)
    end
    
    it 'a plane can take off' do
      plane = double :plane
      airport.stub!(:stormy?).and_return false
      expect(plane).to receive(:take_off!)

      airport.gives_take_off_permission_to(plane)
    end
  end
  
  context 'traffic control' do
    
    it 'airport knows when it is full' do
      plane = double :plane, landed!: nil
      # plane = double(:plane, {:landed! => nil}) - same thing as above
      expect(airport).not_to be_full
      10.times {airport.gives_landing_permission_to(plane)}
      expect(airport).to be_full
    end

    it 'a plane cannot land if the airport is full' do
      # plane = double :plane, landed!:
      plane = double(:plane, {:landed! => nil})
      10.times {airport.gives_landing_permission_to(plane)}
      expect{airport.gives_landing_permission_to(plane)}.to raise_error(RuntimeError)
    end

  end

    
  # Include a weather condition using a module.
  # The weather must be random and only have two states "sunny" or "stormy".
  # Try and take off a plane, but if the weather is stormy, the plane can not take off and must remain in the airport.
  # 
  # This will require stubbing to stop the random return of the weather.
  # If the airport has a weather condition of stormy,
  # the plane can not land, and must not be in the airport
  context 'weather conditions' do

    it 'a plane cannot take off when there is a storm brewing' do
      plane = double :plane, take_off!: nil
      allow(airport).to receive(:stormy?) { true }
      # alternative: airport.stub!(:stormy?).and_return true
      expect{airport.gives_take_off_permission_to(plane)}.to raise_error(RuntimeError)
    end
    
    xit 'a plane cannot land in the middle of a storm' do
    
    end
  end

end