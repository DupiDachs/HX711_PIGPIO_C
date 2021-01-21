# HX711_PIGPIO_C
Simple but effective way to read the HX711 ADC on your Pi at a rate of 80 samples per second without any glitches (no need to filter, etc.) and low CPU usage

On my way of reading out data from the HX711 with the Pi Zero W, I came across alot of libraries, which in the end had some sort of shortcoming:
- Most of them did not handle timings right and generated outliers from time to time
- The python implementation on the pigpio (an impressive library! kudos.) website works fine, but requires too much CPU power for the Pi Zero W at a rate of 80 samples per second. In my application, I would have to waive 2 of 3 readings to have enough headroom left for the rest of the tasks.
- Pigpio has a tick limit of ~72mins, the tool should account for this

# My application
The idea is to measure the force required to extrude filament of a direct extruder of a 3D printer in realtime for dialing in retraction settings, etc. (of course you can use the library for any other application.

# The approach
- Port the pigpio based solution from Python to C for speed improvement. This way, we do not have to rely on the pigpiod daemon. As an initial shot, this lib does not feature everything of the Phython tool - but does the job. :) Feel free to improve it.
- Redirect the readings via stdout to a file. 
- Let websocketd handle communication between a browser and a html page to display the readings.

# The procedure
There might be some things missing. You need some basic skills to install required packages yourself if neccessary and to handle your shell...
Take a look at install.txt for more details.

1. Install pigpio http://abyz.me.uk/rpi/pigpio/download.html
2. (if you want to visualize the data in a browser)
    1. Install websocketd https://github.com/joewalnes/websocketd/releases
       Pick the arm version for the Pi: e.g. websocketd-0.3.1-linux_arm.zip
    2. Install a webserver, e.g. https://elinux.org/RPi-Cam-Web-Interface (I am using this for an attached camera anyway)  
       Copy weigh.html to /var/www/html/ for making it accessible to the outside world  
       Get the two .js files from here https://github.com/perrygeo/pi_sensor_realtime/tree/master/static/vendor and copy them to /var/www/html/
3. Adjust HX711.cpp to your needs. Take a look at the first lines of the code for user settings, like Gain, etc.
    1. Compile HX711.cpp: "gcc -Wall -pthread -o HX711 HX711.cpp -lpigpio -lrt"
    2. Try it out: "sudo ./HX711"
    3. Adjust "run.sh" if necessary to set up everything to your needs (if you want to visualize the data in a browser)

# Readings example
Output is the Unix epoch time in seconds and the reading in gram, separated by a comma. You can observe that every ~11ms, a new reading pops up.  
<img src="https://github.com/DupiDachs/HX711_PIGPIO_C/blob/main/screenshots/readingShell.png" width="250">

# CPU usage
Only running the C code takes up 17% CPU time (83%id) on the Pi Zero W.  
<img src="https://github.com/DupiDachs/HX711_PIGPIO_C/blob/main/screenshots/CPUusage.png" width="500">

Also viewing the result in the browser leaves a bit more than 60% idle.  
<img src="https://github.com/DupiDachs/HX711_PIGPIO_C/blob/main/screenshots/CPUusageBrowser.png" width="500">

Also viewing the attached camera is no issue and still leaves us with more than 50% idle. :)

# Reading example (browser)
No outliers and very sensitive readings. :) These initial waves are coming from me knocking on the table where the sensor is put.  
<img src="https://github.com/DupiDachs/HX711_PIGPIO_C/blob/main/screenshots/readingBrowser.png" width="700">
