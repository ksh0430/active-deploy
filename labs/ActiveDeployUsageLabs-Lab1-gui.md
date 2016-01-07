[![Deploy to Bluemix](https://bluemix.net/deploy/button.png)](https://bluemix.net/deploy?repository=https://github.com/IBM-Bluemix/active-deploy-lab)

# Lab 1: Default Deployment with the Active Deploy Dashboard

This lab will show us how to get started using Active Deploy quickly by doing an automated deployment using a default configuration.

1. Go to the Bluemix Dashboard and click on the Active Deploy service tile. When the Active Deploy Dashboard loads, create a new deployment.
  * Click on the `Create New Deployment` button.
  * Under the `Select Current Version` section, select `hello_app_1`. The `Select New Version` section will populate with application choices based on your Current Version selection.
  * Under the `Select New Version` section, select `hello_app_2`.
  * Click the `Create` button to create the new deployment. Upon successful creation, the page will display the details of the new deployment.

2. Verify that Bluemix starts routing traffic to both versions:
  * Use the `cf apps` command to list all the applications in your Bluemix space. During the _Ramp-up_ phase, you should see both versions of the application have an assigned route (the URL from Step 5 in "Creating an Application in Bluemix").
  * In your browser, you can go to **URL**/index.txt, where **URL** is from Step 5 in "Creating an Application in Bluemix". During the _Ramp-up_ phase, you should see the text alternate between "Hello, Bluemix World 1" and "Hello, Bluemix World 2" as you reload the browser.
  * In the Bluemix Dashboard, you'll see that both `hello_app_1` and `hello_app_2` both have the route assigned to them.
  * (Optional) If you have `curl` installed, you can run curl against the URL. During the _Ramp-up_ phase, you should see the text alternate between "Hello, Bluemix World 1" and "Hello, Bluemix World 2".

3. In the Active Deploy Dashboard, the deployment details page provides information about your deployment, such as the phase completion times and estimated traffic to each version of the application. It also provides the ability to take actions on the deployment, such as pause, rollback, and advance. You can click the Refresh icon in the top right of the deployment details page to refresh the contents of the page.

4. In the Active Deploy Dashboard, click the `Back to Deployments` button. This will take you back to the list of all deployments. This page is the equivalent of the `cf active-deploy-list` command in the Active Deploy CLI. Using the Refresh button in the top-right to keep the page up-to-date, verify that:

  When the phase is _Ramp-up_:
    * `cf apps` and the Bluemix Dashboard should show both that `hello_app_1` and `hello_app_2` are assigned the same route.
    * Reloading your browser should show both responses "Hello, Bluemix World 1" and "Hello, Bluemix World 2"
    * Queries using `curl` should return both "Hello, Bluemix World 1" and "Hello, Bluemix World 2".

  When the phase is _Test_:
    * `cf apps` and the Bluemix Dashboard should show that only `hello_app_2` has a route assigned to it.
    * Reloading your browser should show only the response "Hello, Bluemix World 2".
    * Queries using `curl` should return only "Hello, Bluemix World 2".

  When the phase is _Ramp-down_:
    * `cf apps` and the Bluemix Dashboard should show that only `hello_app_2` has a route assigned to it.
    * Reloading your browser should show only the response "Hello, Bluemix World 2".
    * Queries using `curl` should return only "Hello, Bluemix World 2".

  When the Active Deploy is complete:
    * `cf apps` and the Bluemix Dashboard should show that `hello_app_1` has only a single instance.
    * The deployment is now listed under the _History_ section instead of the active deployment list.

5. Since the deploy has completed, you can now delete the first version of `hello_app_1` using the `cf delete` command:

    `cf delete -f hello_app_1`

Alternatively, you can delete `hello_app_1` using the Bluemix Dashboard by clicking on the Gear icon and clicking `Delete App`.

**After completing these steps, you have:**
1. Created your first deployment using the Active Deploy service using the Active Deploy Dashboard.
2. Used a combination of the deployment details and deployments list pages, your browser, and/or `curl` to see how the Active Deploy service completes a deployment.
3. Used the `cf delete` command or Bluemix Dashboard to delete the old version of the application once the deployment has completed.
