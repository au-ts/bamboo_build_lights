Bamboo Build Lights
===================
Scripts for controlling the red/green seL4 lights and the Lavalamps
based on the build status of Bamboo.

Build status is collected by curl and jq, and telnetted to the device
"dimmer" attacher to the lights.

Alternatively, using the lavalamps.py script running on QBtruck, it
can turn on/off the red/green lavalamps at ATP.

Infrastructure
--------------

Requirements
------------
 - bash
 - jq
 - curl

