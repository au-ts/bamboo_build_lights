#!/usr/bin/env python3
import ftdi1 as ftd
from time import sleep
import sys

# '1' on the controller is wired
# to FTDI bits 0 (off) and 3 (on)
RED_ON = bytes([1<<3])
RED_OFF = bytes([1<<0])

# '2' on the controller is wired to
# FTDI bits 1 (off) and 4 (on)
GREEN_ON = bytes([1<<4])
GREEN_OFF = bytes([1<<1])

# Bits 2, 5, 6, 7 and 8 are not connected.
# To release the button(s) write all
# zeros to the FTDI
NEUTRAL = bytes([0])

# The lavalamps are controlled with a FTDI device wired across the
# ON and OFF buttons on a wireless remote control.
# To actuate the button, it has to be 'pressed' for at least 200ms
# actuate() 'presses' a button by causing the appropriate FTDI bitbanging output
# to pulse for a short time.
def actuate(context, value):
    ftd.write_data(context, value)
    sleep(0.3)
    ftd.write_data(context, NEUTRAL)



def red(context):
    actuate(context, RED_ON)
    actuate(context, GREEN_OFF)

def green(context):
    # turn on Green light
    actuate(context, GREEN_ON)
    actuate(context, RED_OFF)

def off(context):
    actuate(context, RED_OFF)
    actuate(context, GREEN_OFF)


context = ftd.new()
ftd.usb_open(context, 0x0403, 0x6001);
ftd.set_bitmode(context, 0xff, ftd.BITMODE_BITBANG)
# Everything off --- shouldn't be necessary.
ftd.write_data(context, bytes([0x00]))

if len(sys.argv) == 1:
    off(context)
elif sys.argv[1] == 'red':
    red(context)
elif sys.argv[1] == 'green':
    green(context)
else:
    print("Usage: lavalamps [red|green]")
