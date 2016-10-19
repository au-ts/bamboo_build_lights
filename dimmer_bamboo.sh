#!/bin/bash

DIMMER_ID=dimmer
DIMMER_PORT=3500

RED="red"
GREEN="green"
QUIT="quit"
SET_BRIGHTNESS="set"

RED_BRIGHTNESS=30
GREEN_BRIGHTNESS=5

AUTH_USER=bitbucket_user
AUTH_PASS=bitbucket_pass
#REST_URL="bamboo.keg.ertos.in.nicta.com.au:8085/rest/api/latest/result.json"
REST_URL="bamboo.keg.ertos.in.nicta.com.au:8085/rest/api/1.0/result/L4V.json"
QUERY='.results.result | map(select(.plan.shortKey != "TESTBOARD" and .plan.enabled)) | map(select(has("state") and .plan.enabled)) | map("Successful" == .state) | all'
BUILD_SUCCESS='true'

function change_colour {
    { sleep 2;
      echo $SET_BRIGHTNESS $1;
      sleep 0.5;
      echo $2;
      sleep 0.5;
      echo $QUIT; } | telnet $DIMMER_ID $DIMMER_PORT
}

BUILD_STATUS=$(curl $REST_URL | jq "$QUERY")

echo "sel4 Hardware-repo regression status:" $BUILD_STATUS

if [ x$BUILD_STATUS = x$BUILD_SUCCESS ]; then
    change_colour $GREEN_BRIGHTNESS $GREEN
else
    change_colour $RED_BRIGHTNESS $RED
fi

