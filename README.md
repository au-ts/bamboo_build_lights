Bamboo Build Lights
===================
Script for controlling the red/green seL4 lights based on the build status of Bamboo.

Build status is collected by curl and jq, and telnetted to the device "dimmer" attach to the lights.

Infrastructure
--------------
Currently this script is run every 5 minutes from saison. Check /etc/crontab for exact details.

Requirements
------------
 - bash
 - jq
 - curl

