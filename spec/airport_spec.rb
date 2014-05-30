require 'airport'

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
    it 'a plane can land' do
      plane = double :plane
      expect(plane).to receive(:landed!)

      airport.gives_landing_permission_to(plane)
    end
    
    it 'a plane can take off' do
      plane = double :plane
      expect(plane).to receive(:take_off!)

      airport.gives_take_off_permission_to(plane)
    end
  end
  
  context 'traffic control' do
    xit 'a plane cannot land if the airport is full' do


    end
    
    # Include a weather condition using a module.
    # The weather must be random and only have two states "sunny" or "stormy".
    # Try and take off a plane, but if the weather is stormy, the plane can not take off and must remain in the airport.
    # 
    # This will require stubbing to stop the random return of the weather.
    # If the airport has a weather condition of stormy,
    # the plane can not land, and must not be in the airport
    context 'weather conditions' do
      xit 'a plane cannot take off when there is a storm brewing' do
      end
      
      xit 'a plane cannot land in the middle of a storm' do
      end
    end
  end
end