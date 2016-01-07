[//]: # ([![Deploy to Bluemix](https://bluemix.net/deploy/button.png)](https://bluemix.net/deploy?repository=https://github.com/IBM-Bluemix/active-deploy-lab))

# Lab 3: Manual Progression Deployment

**Intent:** This lab explores the manual progression deployment, and how it differs from an automatic deployment.

> **Difficulty**: Easy

> **Time**: 15 minutes

> **Prerequisites**:
- Make sure you have satisfied the prerequisite steps listed on the main lab page
- Make sure you have a running application in Bluemix. If need be, use the SampleApp steps on the main lab page.

##Steps

1. Make a change to the `index.txt` file in the sample application.
  * Change the text "Hello, Bluemix World **3**" to "Hello, Bluemix World **4**".

2. Use the CloudFoundry command line to publish the fourth version of the sample application to Bluemix. Run the following command in your terminal/command prompt:

    `cf push hello_app_4 --no-route`

    Notice the new name (`hello_app_4`), and the option `--no-route`.

3. Use the Active Deploy Dashboard to create a new deployment, with custom options to specify phase durations, name, and a manual progression deployment.

  * Go to the Bluemix Dashboard and click on the Active Deploy service tile. When the Active Deploy Dashboard loads, click on the `Create New Deployment` button.
  * Under the `Select Current Version` section, select `hello_app_3`. The `Select New Version` section will populate with application choices based on your Current Version selection.
  * Under the `Select New Version` section, select `hello_app_4`.
  * Assign the deployment the name of `manual_lab`.
  * Assign desired durations of 1 minute to the _Ramp-up_, _Test_, and _Ramp-down_ phases.
  * Click the `Create` button to create the new deployment. Upon successful creation, the page will display the details of the new deployment.

  Active Deploy routes traffic to `hello_app_4` and starts ramping up instances.

4. Using the Refresh button in the top-right of the deployment details page to keep the information up-to-date, verify that:

  When the phase is _Ramp-up_:
    * `cf apps` and the Bluemix Dashboard should show both that `hello_app_3` and `hello_app_4` are assigned the same route.
    * Reloading your browser should show both responses "Hello, Bluemix World 3" and "Hello, Bluemix World 4"
    * Queries using `curl` should return both "Hello, Bluemix World 3" and "Hello, Bluemix World 4".

  Since this is a manual progression deployment, Active Deploy won't progress from the Ramp-up phase to the Test phase until you manually advance the deployment. On the deployment details page, you can use the `Force Advance` button. On the deployments list page, you can click the gear icon next to the deployment and choose the `Force Advance` option. This is equivalent to the `cf active-deploy-advance` command in the Active Deploy CLI. You could use this opportunity to monitor and test the new version of the application while it has limited traffic (before it receives all traffic in the Test phase).

5. Advance the deployment to the Test phase by using the `Force Advance` button on the deployment details page.

6. Using the Refresh button in the top-right of the deployment details page to keep the information up-to-date, verify that:

  When the phase is _Test_:
    * `cf apps` and the Bluemix Dashboard should show that only `hello_app_4` has a route assigned to it.
    * Reloading your browser should show only the response "Hello, Bluemix World 4".
    * Queries using `curl` should return only "Hello, Bluemix World 4".

7. Because you specified a manual-transition deployment, Active Deploy will not automatically transition from the Test phase to the Ramp-down phase.  This allows you to take as long as you want during the Test phase.  This could mean extended manual testing, and you can use the `Force Advance` button when you are finished with testing.

  Use the `Force Advance` button to advance the deployment to the Ramp-down phase.

8. Using the Refresh button in the top-right of the deployment details page to keep the information up-to-date, verify that:

  When the phase is _Ramp-down_:
    * `cf apps` and the Bluemix Dashboard should show that only `hello_app_4` has a route assigned to it.
    * Reloading your browser should show only the response "Hello, Bluemix World 4".
    * Queries using `curl` should return only "Hello, Bluemix World 4".

9. After the manual_lab deployment is complete, you may delete the `hello_app_3` app using the `cf delete` command:

  `cf delete -f hello_app_3`

Alternatively, you can delete `hello_app_3` using the Bluemix Dashboard by clicking on the Gear icon and clicking `Delete App`.

**After completing this lab, you have:**
1. Created a deployed a fourth version of the application to Bluemix.
2. Created a manual-transition deployment using the Active Deploy Dashboard.
3. Used the `Force Advance` button to advance a manual-transition deployment from one phase to another.
