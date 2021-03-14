#!/bin/bash

# Unused.
#AUTH_USER=bitbucket_user
#AUTH_PASS=bitbucket_pass
DIR="`dirname $0`"

REST_URL="https://bamboo.ts.data61.csiro.au/rest/api/1.0/result/L4V.json"
QUERY='.results.result | map(select(.plan.shortKey != "TESTBOARD" and .plan.enabled)) | map(select(has("state") and .plan.enabled)) | map("Successful" == .state) | all'
BUILD_SUCCESS='true'

BUILD_STATUS=$(curl $REST_URL | jq "$QUERY")

echo "sel4 Hardware-repo regression status:" $BUILD_STATUS

if [ x$BUILD_STATUS = x$BUILD_SUCCESS ]; then
    "$DIR"/lavalamps.py green
else
    "$DIR"/lavalamps.py red
fi

