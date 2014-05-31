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
  
  context '- setting capacity -' do

    it 'should allow setting of maximum capacity on initializing' do
      expect(airport.capacity).to eq 10 
    end

  end

  context '- taking off and landing -' do

    it 'a plane that is given landing permission actually lands' do
      plane = double :plane, landed!: nil
      allow(airport).to receive(:stormy?) { false }
      airport.gives_landing_permission_to(plane)
      expect(airport.hangar).to include plane
    end

    it 'a plane receives landing status when it lands in the airport' do
      plane = double :plane
      allow(airport).to receive(:stormy?) { false }
      expect(plane).to receive(:landed!)
      airport.gives_landing_permission_to(plane)
    end

    it 'a plane that is given take off permission actually takes off' do
      plane = double :plane, landed!: nil, take_off!: nil
      allow(airport).to receive(:stormy?) { false }
      airport.gives_landing_permission_to(plane)
      airport.gives_take_off_permission_to(plane)
      expect(airport.hangar).not_to include plane
    end
    
    it 'a plane receives flying status when it takes off from the airport' do
      plane = double :plane
      allow(airport).to receive(:stormy?) { false }
      # airport.stub!(:stormy?).and_return false
      expect(plane).to receive(:take_off!)
      airport.gives_take_off_permission_to(plane)
    end

  end
  
  context 'traffic control -' do
    
    it 'airport knows when it is full' do
      plane = double :plane, landed!: nil
      # plane = double(:plane, {:landed! => nil}) - same thing as above
      allow(airport).to receive(:stormy?) { false }
      expect(airport).not_to be_full
      10.times {airport.gives_landing_permission_to(plane)}
      expect(airport).to be_full
    end

    it 'a plane cannot land if the airport is full' do
      # plane = double :plane, landed!:
      plane = double(:plane, {:landed! => nil})
      allow(airport).to receive(:stormy?) { false }
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

    it 'knows when the weather is stormy' do
      allow(airport).to receive(:stormy?) { true }
      expect(airport.stormy?).to be_true
    end

    it 'a plane cannot take off when there is a storm brewing' do
      plane = double :plane, take_off!: nil
      allow(airport).to receive(:stormy?) { true }
      # alternative: airport.stub!(:stormy?).and_return true
      expect{airport.gives_take_off_permission_to(plane)}.to raise_error(RuntimeError)
    end
    
    it 'a plane cannot land in the middle of a storm' do
      plane = double :plane, take_off!: nil
      allow(airport).to receive(:stormy?) { true }
      expect{airport.gives_landing_permission_to(plane)}.to raise_error(RuntimeError)
    end

  end

end

# grand final
# Given 6 planes, each plane must land. When the airport is full, every plane must take off again.
# Be careful of the weather, it could be stormy!
# Check when all the planes have landed that they have the right status "landed"
# Once all the planes are in the air again, check that they have the status of flying!
describe "The grand finale" do
  
  let(:airport) { Airport.new(capacity: 6) }
  let(:plane) { Plane.new}

  it 'all planes can land and take off eventually' do
    plane_queue = Plane.new, Plane.new, Plane.new, Plane.new, Plane.new, Plane.new
    plane_queue.each do |plane|
      expect(plane.flying?).to be_true
      
      begin
        airport.gives_landing_permission_to(plane)
      rescue RuntimeError
        "Weather is too stormy; plane tries again later"
        redo
      end
      expect(plane.flying?).not_to be_true

      begin
        airport.gives_take_off_permission_to(plane)
      rescue RuntimeError
        "Weather is too stormy; plane tries again later"
        redo
      end
      expect(plane.flying?).to be_true
    end
    expect(airport.hangar).to be_empty
  end

end