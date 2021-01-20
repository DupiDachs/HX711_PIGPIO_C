# HX711_PIGPIO_C
Simple but effective way to read the HX711 ADC on your Pi at a rate of 80 samples per second without any glitches and low CPU usage

On my way of reading out data from the HX711 with the Pi Zero W, I came across alot of libraries, which in the end had some sort of shortcoming:
- Most of them did not handle timings right and generated outliers from time to time
- The python implementation on the pigpio (an impressive library! kudos.) website works fine, but requires too much CPU power for the Pi Zero W at a rate of 80 samples per second. In my application, I would have to waive 2 of 3 readings to have enough headroom left for the rest of the tasks.

# My application
The idea is to measure the force required to extrude filament of a direct extruder of a 3D printer in realtime for dialing in retraction settings, etc. (of course you can use the library for any other application.

# Approach
- Port the pigpio based solution from Python to C for speed improvement. This way, we do not have to rely on the pigpiod daemon. As an initial shot, this lib does not feature everything of the Phython tool - but does the job. :) Feel free to improve it.
- Redirect the readings via stdout to a file. 
- Let websocketd handle communication between a browser and a html page to display the readings.

# Step by step
tbd
