[//]: # ([![Deploy to Bluemix](https://bluemix.net/deploy/button.png)](https://bluemix.net/deploy?repository=https://github.com/IBM-Bluemix/active-deploy-lab))

# Active Deploy

You can update running apps with no downtime, by using the intelligent update capabilities of the Active Deploy service. You can also quickly revert to the original version.

If your goal is to update apps with no downtime, you can do that with a managed update that is done in phases. Rolling deployments are often called blue-green deployments, red-black deployments, or zero-downtime deployments. Although these deployment processes differ in subtle ways, they share the core principle of avoiding a disruption in service for the consumer. With this service, you can deploy a new version by using a continual process, such that the new version is finalized only when it proves to work properly in production. In a nutshell, you have these options:

* Manage the rollout of changes in an automated and controlled fashion.
* Roll back your changes if needed.
* Have two versions be "live" at one time, each one with specific amounts of routed traffic.

## Active Deploy Labs
We have created several labs to help get you acquainted with the Active Deploy service.

The main lab page can be found [here](./labs/README.md).

## Blog Posts about Active Deploy
* [Bluemix Active Deploy – Zero-Downtime Deployment](https://developer.ibm.com/bluemix/2015/10/09/bluemix-zero-downtime-deployment)
* [Diving into the Bluemix Active Deploy service](https://developer.ibm.com/bluemix/2015/10/19/getting-started-with-bluemix-active-deploy/)
