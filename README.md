Airport Traffic Simulator
=========================

This was the challenge set at the end of Week 3 at Makers Academy.

The objective was to write Ruby code to control the flow of planes at an airport. The planes can land and take off provided that the weather is sunny. Occasionally it may be stormy, in which case no planes can land or take off. 

<b>Classes</b>
- Plane (with a flying or landed state)
- Airport (with maximum capacity)

<b>Modules</b>
- Weather (randomly generates either a sunny or stormy state)

Technologies used
-----------------

* Ruby
* RSpec
* Git

How to use
----------

```shell
git clone git@github.com:juliatan/airport_traffic_sim.git
cd airport_traffic_sim
irb
require './lib/airport_sim'
```

Create new instances of planes and airports and make the planes fly and land through IRB.

How to run tests
----------------

```shell
cd airport_traffic_sim
rspec
```
