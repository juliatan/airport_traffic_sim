require 'plane'

# When we create a new plane, it should have a "flying" status, thus planes can not be created in the airport.
#
# When we land a plane at the airport, the plane in question should have its status changed to "landed"
#
# When the plane takes of from the airport, the plane's status should become "flying"

describe Plane do
 
  let(:plane) { Plane.new }
  
  it 'has a flying status when created' do
  	expect(plane).to be_flying
  end
  
  it 'changes its status to flying after taking of' do
  	expect(plane.take_off!).to be_flying
  end

  it 'changes its status to landed after landing' do
  	expect(plane.landed!).not_to be_flying
  end

  xit 'has a flying status when in the air' do
  
  end
  
  xit 'can take off' do

  end
  
  

end