[![Deploy to Bluemix](https://bluemix.net/deploy/button.png)](https://bluemix.net/deploy?repository=https://github.com/IBM-Bluemix/active-deploy-lab)

# Prerequisites

A few steps to get started - done only once and depend on your desktop type. Skip any steps you have already accomplished.

1. Create a Bluemix log in
    * [bluemix.net](http://bluemix.net) - sign up is free and immediate
    * Access your org space => Log into Bluemix and go to your default Org space here
2. Install Git for your platform => [Download Git](https://git-scm.com/downloads)
3. Install the Cloud Foundry CLI for your platform from the [Cloud Foundry CLI GitHub repository](https://github.com/cloudfoundry/cli/releases)
4. Login to Bluemix in a terminal/at a command prompt:
    `cf login -u EMAIL@ADDRESS -p PASSWORD -a api.ng.bluemix.net`
5. Download and install the Active Deploy service plugin for the Cloud Foundry CLI

    `cf add-plugin-repo bluemix http://plugins.ng.bluemix.net`

    `cf install-plugin active-deploy -r bluemix`

    You can verify the plugins are installed by executing `cf plugins`. You should see a list of items prefixed by _active-deploy_.
6. (Optional) Install cURL for your platform => [Download cURL](http://curl.haxx.se/download.html)

After completing these prerequisites, you have the needed infrastructure to talk to Bluemix and execute the Active Deploy commands.

## Bonus Extra Credit
* Read [Active Deploy's official documentation](https://www.ng.bluemix.net/docs/services/ActiveDeploy/index.html) - read what you like from the overview - link to embedded topics when you want.
