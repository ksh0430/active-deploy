# Active Deploy Script Integration


## Calling Active Deploy from Bluemix-external Build Processes

The script ActiveDeploy-script_integration-example.sh in this shows you an example of how you would call Active Deploy from your Cloud application build process that then delivers to the Bluemix cloud platform. For example, you can call this from Jenkins to do that delivery.

Notes:
- if you want to use the Bluemix Delivery Pipeline, we have a better solution here [pending]
- This script is only partially "turn-key". It's fairly well complete - but you need to make sure that it is the flavor of results that you want. Does it handle deployment results the way you like? Does it notify you properly of certain statuses?

## Calling Active Deploy from IBM Continuous Delivery Pipeline for Bluemix

The detailed blog post covering the out of box support is here: 
https://developer.ibm.com/bluemix/2016/03/17/bluemix-active-deploy-with-pipeline-integration/
This blog post contains detailed information as well as pointers to the tutorial. 
