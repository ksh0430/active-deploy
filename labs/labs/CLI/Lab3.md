# Lab 3: Manual Progression Deployment

**Intent:** This lab explores the manual progression deployment, and how it differs from an automatic deployment.

> **Difficulty**: Easy

> **Time**: 15 minutes

> **Prerequisites**:
- Make sure you have satisfied the prerequisite steps listed on the main lab page
- Make sure you have a running application in Bluemix. If need be, use the SampleApp steps on the main lab page.

## Steps

1. Make a change to the `index.txt` file in the sample application.
  * Change the text "Hello, Bluemix World **3**" to "Hello, Bluemix World **4**".

2. Use the CloudFoundry command line to publish the fourth version of the sample application to Bluemix. Run the following command in your terminal/command prompt:

    `cf push hello_app_4 --no-route`

    Notice the new name (`hello_app_4`), and the option `--no-route`.

3. Use the `cf active-deploy-create` command to create a new deployment, with custom options to specify custom phase durations, a custom label, and a manual progression deployment.

    `cf active-deploy-create hello_app_3 hello_app_4 --manual --label manual_lab --rampup 1m --test 1m --rampdown 1m`

    Active Deploy routes traffic to `hello_app_4` and starts ramping up instances.

4. List the deployments of the Active Deploys service using the `cf active-deploy-list` command:

    `cf active-deploy-list`

    When the phase is _rampup_:
      * `cf apps` should show both that `hello_app_3` and `hello_app_4` are assigned the same route.
      * Reloading your browser should show both responses "Hello, Bluemix World 3" and "Hello, Bluemix World 4"
      * Queries using `curl` should return both "Hello, Bluemix World 3" and "Hello, Bluemix World 4".

    Since this is a manual progression deployment, Active Deploy won't progress from the Ramp-up phase to the Test phase until you manually advance the deployment using the `cf active-deploy-advance` command. You could use this opportunity to monitor and test the new version of the application while it has limited traffic (before it receives all traffic in the Test phase).

5. Use the `cf active-deploy-advance` command to advance the deployment to the Test phase.

    `cf active-deploy-advance manual_lab`

    If the command fails with an error message because the current phase has not yet completed, you can try forcing the deployment to advance by passing the `--force` flag:

    `cf active-deploy-advance manual_lab --force`

    The `--force` flag tells Active Deploy to complete processing of current phase as quickly as possible and begin execution of the next phase.

6. List the deployments of the Active Deploys service using the `cf active-deploy-list` command:

    `cf active-deploy-list`

    When the phase is _test_:
      * `cf apps` should show that only `hello_app_4` has a route assigned to it.
      * Reloading your browser should show only the response "Hello, Bluemix World 4".
      * Queries using `curl` should return only "Hello, Bluemix World 4".

7. Because you specified a manual-transition deployment, Active Deploy will not automatically transition from the Test phase to the Ramp-down phase.  This allows you to take as long as you want during the Test phase.  This could mean extended manual testing, with a second manual `cf active-deploy-advance manual_lab` when you are finished with manual testing.  It is also a way to create your own rollout scripts.  You can write your tests scripts so that if they pass your scripts are in charge of running `cf active-deploy-advance`.

    Use the `cf active-deploy-advance` command to advance the deployment to the Ramp-down phase.

    `cf active-deploy-advance manual_lab`

    If the command fails with an error message, you can try forcing the deployment to advance by passing the `--force` flag:

    `cf active-deploy-advance manual_lab --force`

8. List the deployments of the Active Deploys service using the `cf active-deploy-list` command:

    `cf active-deploy-list`

    When the phase is _rampdown_:
      * `cf apps` should show that only `hello_app_4` has a route assigned to it.
      * Reloading your browser should show only the response "Hello, Bluemix World 4".
      * Queries using `curl` should return only "Hello, Bluemix World 4".

9. After the manual_lab deployment is complete, you may delete the `hello_app_3` app using the `cf delete` command:

    `cf delete -f hello_app_3`

**After completing this lab, you have:**
1. Created a deployed a fourth version of the application to Bluemix.
2. Created a manual-transition deployment using the Active Deploy service using the `--manual` flag.
3. Used the `cf active-deploy-advance` command to advance a manual-transition deployment from one phase to another.
