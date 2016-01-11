[//]: # ([![Deploy to Bluemix](https://bluemix.net/deploy/button.png)](https://bluemix.net/deploy?repository=https://github.com/IBM-Bluemix/active-deploy-lab))

# Lab 2: Custom Deployment

**Intent:** This lab will show us the customizability of Active Deploy by customizing the phase durations when creating our deployments.

> **Difficulty**: Easy

> **Time**: 15 minutes

> **Prerequisites**:
- Make sure you have satisfied the prerequisite steps listed on the main lab page
- Make sure you have a running application in Bluemix. If need be, use the SampleApp steps on the main lab page.

## Steps

1. Make a change to the `index.txt` file in the sample application.
  * Change the text "Hello, Bluemix World **2**" to "Hello, Bluemix World **3**".

2. Use the CloudFoundry command line to publish the third version of the sample application to Bluemix. Run the following command in your terminal/command prompt:

    `cf push hello_app_3 --no-route`

    Notice the new name (`hello_app_3`), and the option `--no-route`.

3. To see a list of possible custom options for the `cf active-deploy-create` command, run the following command in your terminal/command prompt:

    `cf active-deploy-create -h`

    Note how you can assign the deployment a custom label and description, change the verbosity of the command's output, and customize each phase's duration.
    A label allows you to refer to the deployment using a name of your choosing.

4. Use the `cf active-deploy-create` command to create a new deployment, with custom options to specify a label and Ramp-up and Test phase durations of 1 minute each.

    `cf active-deploy-create hello_app_2 hello_app_3 --label custom_lab --rampup 1m --test 60s`

    As in Lab 1, Active Deploy begins by routing traffic to `hello_app_3` and ramping up the number of instances of `hello_app_3`.

5. List the deployments of the Active Deploys service using the `cf active-deploy-list` command:

    `cf active-deploy-list`

    When the phase is _rampup_:
      * `cf apps` should show both that `hello_app_2` and `hello_app_3` are assigned the same route.
      * Reloading your browser should show both responses "Hello, Bluemix World 2" and "Hello, Bluemix World 3"
      * Queries using `curl` should return both "Hello, Bluemix World 2" and "Hello, Bluemix World 3".

    When the phase is _test_:
      * `cf apps` should show that only `hello_app_3` has a route assigned to it.
      * Reloading your browser should show only the response "Hello, Bluemix World 3".
      * Queries using `curl` should return only "Hello, Bluemix World 3".

    When the phase is _rampdown_:
      * `cf apps` should show that only `hello_app_3` has a route assigned to it.
      * Reloading your browser should show only the response "Hello, Bluemix World 3".
      * Queries using `curl` should return only "Hello, Bluemix World 3".

    When the Active Deploy is complete:
      * `cf apps` should show that `hello_app` has only a single instance.

6. Inspect the progress of the `custom_lab` Active Deploy using the `cf active-deploy-show` command:

    `cf active-deploy-show custom_lab`

7. Once the deployment completes, delete `hello_app_2` using the `cf delete` command:

    `cf delete -f hello_app_2`

**After completing these steps, you have:**
1. Created and deployed a third version of the application to Bluemix.
2. Learned about the custom options available when creating a deployment using the Active Deploy service.
3. Created a deployment with a customized label and Ramp-up and Test phase durations.
4. Learned how to monitor the progress of a deployment using the `cf active-deploy-show` command.
