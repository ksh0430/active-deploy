#!/bin/bash

#********************************************************************************
# Copyright 2016 IBM
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#********************************************************************************

#********************************************************************************
# Purpose: This script shows you how to call Active Deploy from an script. For 
# example, you are doing build and deployment work and you want to call 
# Active Deploy instead of the direct CF or Container commands you are using now.
# Maybe you are using Jenkins and want to call out to Active Deploy.
#
# Usage: This is no a finalized script - you will need to potentially modify 
# it to suit your own purpose: change time outs, set variables, handle conditions.
# Use it as a starting point and modify as you see fit.
#
# Questions: Please use the normal support channels
#
#********************************************************************************


# This finds what the current execution directory is
SCRIPTDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

# Sets up tracing
set -x # trace steps

# Log some helpful information for debugging
env
find . -print


# Setup for Active Deploy phase times - you may or may not use these, although you probably should control how long you want it to run.

### Very fast deploy
# rampup="1m"
# test="1s"
# rampdown="1m"

### Moderate speed deploy
# rampup="10m"
# test="10m"
# rampdown="5m"



# Start the active deploy - record back the Active Deploy identification
id=$(cf active-deploy-create $old_app_name $new_app_name -u $rampup -t $test -w $rampdown | grep "deployment id:" | awk '{print $3}')

# Get the status of deploy using id
status=$(cf active-deploy-check-status "$id" -q)

#Status values are listed here => https://www.ng.bluemix.net/docs/services/ActiveDeploy/index.html - Basically they are:
# Status - Description
# in_progress - The deployment is running
# paused - The deployment is paused
# completed - The deployment is completed
# rolling_back - The deployment is being rolled back to the initial phase
# rolled_back - The deployment is rolled back to the initial phase
# failed - The deployment failed; and an error message is displayed

# Loop while active deploy is in progress
### TODO: Also might want to put a counter on this and time out depending on your timing settings after it's clearly hung

# ED: Can you please write a variable that indexes base on some setable timer? Like 50% longer than their entire phase timings?
# so if your timings bring you to say 75 min - and say +15 min you should bail and declare failure
# Like TIMEOUT = rampup+test+rampdown + 1.50
# Then if that timeout is passed?
# Or something like that


while [ $status = "in_progress" ] && [ PAST TIMEOUT RANGE ]
do
	sleep 60
 	status=$(cf active-deploy-check-status "$id" -q)
done

if [[ "${update_status}" == 'paused' ]]; then
  echo "Deployment is in paused"

elif [[ "${update_status}" == 'completed' ]]; then
  echo "Deployment is in completed"
  
elif [[ "${update_status}" == 'rolling_back' ]]; then
  echo "Deployment is in rolling_back"
  
elif [[ "${update_status}" == 'rolled_back' ]]; then
  echo "Deployment is in rolled_back"
  
elif [[ "${update_status}" == 'failed' ]]; then
  echo "Deployment is in failed"
  
else
  echo "Deployment is in 'no idea'"
  
fi

#ED: What else should we mention to them here? Clean up? Deleting the noew v1 1 instance group?

