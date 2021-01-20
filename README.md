# HX711_PIGPIO_C
Simple but effective way to read the HX711 ADC on your Pi at a rate of 80 samples per second without any glitches (no need to filter, etc.) and low CPU usage

On my way of reading out data from the HX711 with the Pi Zero W, I came across alot of libraries, which in the end had some sort of shortcoming:
- Most of them did not handle timings right and generated outliers from time to time
- The python implementation on the pigpio (an impressive library! kudos.) website works fine, but requires too much CPU power for the Pi Zero W at a rate of 80 samples per second. In my application, I would have to waive 2 of 3 readings to have enough headroom left for the rest of the tasks.
- Pigpio has a tick limit of ~72mins, the tool should account for this

# My application
The idea is to measure the force required to extrude filament of a direct extruder of a 3D printer in realtime for dialing in retraction settings, etc. (of course you can use the library for any other application.

# Approach
- Port the pigpio based solution from Python to C for speed improvement. This way, we do not have to rely on the pigpiod daemon. As an initial shot, this lib does not feature everything of the Phython tool - but does the job. :) Feel free to improve it.
- Redirect the readings via stdout to a file. 
- Let websocketd handle communication between a browser and a html page to display the readings.

# Step by step
I am sure some things will be missing here. You need some basic skills to install required packages yourself if neccessary...

1. Install pigpio http://abyz.me.uk/rpi/pigpio/download.html
2. (if you want to visualize the data in a browser)
2.1. Install websocketd https://github.com/joewalnes/websocketd/releases
2.1.1. Pick the arm version for the Pi: e.g. websocketd-0.3.1-linux_arm.zip
2.2. Install a webserver, e.g. https://elinux.org/RPi-Cam-Web-Interface (I am using this for an attached camera anyway)
2.2.1. Copy weigh.html to /var/www/html/ for making it accessible to the outside world
2.2.2. Get the two .js files from here https://github.com/perrygeo/pi_sensor_realtime/tree/master/static/vendor and copy them to /var/www/html/
3. Compile HX711.cpp: "gcc -Wall -pthread -o HX711 HX711.cpp -lpigpio -lrt"
3.1. Try it out: "sudo ./HX711"
3.2. Adjust "run.sh" if necessary to set up everything to your needs (if you want to visualize the data in a browser)

# Readings example

