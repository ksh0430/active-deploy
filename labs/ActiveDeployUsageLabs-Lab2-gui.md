[![Deploy to Bluemix](https://bluemix.net/deploy/button.png)](https://bluemix.net/deploy?repository=https://github.com/IBM-Bluemix/active-deploy-lab)

# Lab 2: Custom Deployment with the Active Deploy Dashboard

This lab will show us the customizability of Active Deploy by customizing the phase durations when creating our deployments.

1. Make a change to the `index.txt` file in the sample application.
  * Change the text "Hello, Bluemix World **2**" to "Hello, Bluemix World **3**".

2. Use the CloudFoundry command line to publish the third version of the sample application to Bluemix. Run the following command in your terminal/command prompt:

  `cf push hello_app_3 --no-route`

  Notice the new name (`hello_app_3`), and the option `--no-route`.

3. Go to the Bluemix Dashboard and click on the Active Deploy service tile. When the Active Deploy Dashboard loads, create a new deployment.
  * Click on the `Create New Deployment` button.
  * Under the `Select Current Version` section, select `hello_app_2`. The `Select New Version` section will populate with application choices based on your Current Version selection.
  * Under the `Select New Version` section, select `hello_app_3`.
  * Under the `Name` section, assign the deployment the name of `custom_lab`.
  * Note how you can customize the desired durations of the _Ramp-up_, _Test_, and _Ramp-down_ phases. Change the desired durations of the _Ramp-up_ and _Test_ phases to 1 minute.
  * Click the `Create` button to create the new deployment. Upon successful creation, the page will display the details of the new deployment.

  As in Lab 1, Active Deploy begins by routing traffic to `hello_app_3` and ramping up the number of instances of `hello_app_3`.

4. In the Active Deploy Dashboard, the deployment details page has a progress bar under the `Progress` section that shows the current phase of the deployment, and the completion times of previous phases. This page is the equivalent of the `cf active-deploy-show` command in the Active Deploy CLI. Using the Refresh button in the top-right to keep the page up to date, verify that:

  When the phase is _Ramp-up_:
    * `cf apps` and the Bluemix Dashboard should show both that `hello_app_2` and `hello_app_3` are assigned the same route.
    * Reloading your browser should show both responses "Hello, Bluemix World 2" and "Hello, Bluemix World 3"
    * Queries using `curl` should return both "Hello, Bluemix World 2" and "Hello, Bluemix World 3".

  When the phase is _Test_:
    * `cf apps` and the Bluemix Dashboard should show that only `hello_app_3` has a route assigned to it.
    * Reloading your browser should show only the response "Hello, Bluemix World 3".
    * Queries using `curl` should return only "Hello, Bluemix World 3".

  When the phase is _Ramp-down_:
    * `cf apps` and the Bluemix Dashboard should show that only `hello_app_3` has a route assigned to it.
    * Reloading your browser should show only the response "Hello, Bluemix World 3".
    * Queries using `curl` should return only "Hello, Bluemix World 3".

  When the Active Deploy is complete:
    * `cf apps` and the Bluemix Dashboard should show that `hello_app_2` has only a single instance.
    * In the Active Deploy Dashboard, click the `Back to Deployments` button, which will take you back to the list of all deployments. The current deployment is now listed under the _History_ section instead of the active deployment list.

5. Once the custom_lab deployment completes, delete `hello_app_2` using the `cf delete` command:

  `cf delete -f hello_app_2`

Alternatively, you can delete `hello_app_2` using the Bluemix Dashboard by clicking on the Gear icon and clicking `Delete App`.

** After completing these steps, you have:**
1. Created and deployed a third version of the application to Bluemix.
2. Learned about the custom options available when creating a deployment using the Active Deploy service.
3. Created a deployment with a customized label and Ramp-up and Test phase durations.
