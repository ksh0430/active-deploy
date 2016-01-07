[//]: # ([![Deploy to Bluemix](https://bluemix.net/deploy/button.png)](https://bluemix.net/deploy?repository=https://github.com/IBM-Bluemix/active-deploy-lab))

# Lab 1: Default Deployment with the CLI

**Intent:** This lab will show us how to get started using Active Deploy quickly by doing an automated deployment using a default configuration.

> **Difficulty**: Easy

> **Time**: 15 minutes

> **Prerequisites**:
- Make sure you have satisfied the prerequisite steps listed on the main lab page
- Make sure you have a running application in Bluemix. If need be, use the SampleApp steps on the main lab page.

##Steps

1. Use the `cf active-deploy-create` command to create a new deployment.
It requires the names of the current (routed) version of the application and the new (unrouted) version.

    `cf active-deploy-create hello_app_1 hello_app_2`

    Active Deploy will:
    * Route traffic to `hello_app_2` and start ramping up instances of `hello_app_2` (the Ramp-up Phase).
    * Turn off the route to `hello_app_1` once the number of instances of `hello_app_2` is the same as for `hello_app_1` (the Test Phase).
    * Finally, reduce the number of instances of `hello_app_1` to 1 (the Ramp-down Phase).

2. Verify that Bluemix starts routing traffic to both versions:
    * Use the `cf apps` command to list all the applications in your Bluemix space. During the _Ramp-up_ phase, you should see both versions of the application have an assigned route (the URL from Step 5 in "Creating an Application in Bluemix").
    * In your browser, you can go to **URL**/index.txt, where **URL** is from Step 5 in "Creating an Application in Bluemix". During the _Ramp-up_ phase, you should see the text alternate between "Hello, Bluemix World 1" and "Hello, Bluemix World 2" as you reload the browser.
    * (Optional) If you have `curl` installed, you can run curl against the URL. During the _Ramp-up_ phase, you should see the text alternate between "Hello, Bluemix World 1" and "Hello, Bluemix World 2".

3. List the deployments of the Active Deploys service using the `cf active-deploy-list` command

    `cf active-deploy-list`

    When the phase is _rampup_:
      * `cf apps` should show both that `hello_app_1` and `hello_app_2` are assigned the same route.
      * Reloading your browser should show both responses "Hello, Bluemix World 1" and "Hello, Bluemix World 2"
      * Queries using `curl` should return both "Hello, Bluemix World 1" and "Hello, Bluemix World 2".

    When the phase is _test_:
      * `cf apps` should show that only `hello_app_2` has a route assigned to it.
      * Reloading your browser should show only the response "Hello, Bluemix World 2".
      * Queries using `curl` should return only "Hello, Bluemix World 2".

    When the phase is _rampdown_:
      * `cf apps` should show that only `hello_app_2` has a route assigned to it.
      * Reloading your browser should show only the response "Hello, Bluemix World 2".
      * Queries using `curl` should return only "Hello, Bluemix World 2".

    When the Active Deploy is complete:
      * `cf apps` should show that `hello_app_1` has only a single instance.

4. Since the deploy has completed, you can now delete the first version of `hello_app_1` using the `cf delete` command:

    `cf delete -f hello_app_1`

**After completing these steps, you have:**
1. Created your first deployment using the Active Deploy service using the `cf active-deploy-create` command.
2. Used a combination of the `cf active-deploy-list` and `cf apps` commands, your browser, and/or `curl` to see how the Active Deploy service completes a deployment.
3. Used the `cf delete` command to delete the old version of the application once the deployment has completed.
