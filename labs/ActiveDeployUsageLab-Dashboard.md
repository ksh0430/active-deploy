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
5. Add the Active Deploy service to your Bluemix space.
    * From the Bluemix Dashboard, click on `Use Services or APIs`.
    * Scroll down to the DevOps Section and click on `Active Deploy`.
    * Click the `Create` button. The Active Deploy service will be added to your Bluemix space.
6. (Optional) Install cURL for your platform => [Download cURL](http://curl.haxx.se/download.html)

After completing these prerequisites, you have the needed infrastructure to talk to Bluemix and use the Active Deploy Dashboard.

# Create an Application in Bluemix

This exercise will show us how to clone a repository, push a sample application to Bluemix, and how to re-deploy our application as a new version once we've made changes to it.

1. Use `git` to clone the repository hosting the sample application. Run the following command in your terminal/command prompt (or the Git command line on Windows):

    `git clone https://hub.jazz.net/git/esnible/static-hello`

    The application is a simple web page that displays the text: "Hello, Bluemix World 1".

2. In your terminal/command prompt, log into Bluemix using `cf login`:

    `cf login -u EMAIL@ADDRESS -p PASSWORD -a api.ng.bluemix.net [-s SPACE]` - space is only needed if you know what you're doing and have multiple spaces

3. In your terminal/command prompt, change into the directory/folder containing the sample application you cloned in Step 1:

    `cd static-hello`

4. Use the CloudFoundry command line to publish the sample application to Bluemix. Run the following command in your terminal/command prompt:

    `cf push hello_app_1 -i 2`

    This pushes 2 instances (cf. `-i 2`) of the application to your Bluemix space and assigns it the name `hello_app_1`.
    Application specific defaults may be specified in a `manifest.yml` file and can be overridden by command line arguments.
    For example, the `manifest.yml` file for this application specifies that the route for the application should be assigned randomly.

5. While your sample application is being deployed to Bluemix, note the route (URL) that is assigned to the application. Look for a line near the end such as:

    `urls: hello-app-test-commutual-seiche.mybluemix.net...`

    In this instance, the route is `hello-app-test-commutual-seiche.mybluemix.net`.

6. Verify the application is started and working:
  * To view information about the deployed application, use the `cf app` command:

        `cf app hello_app_1`
  * To see summary information about all deployed applications, use the command: `cf apps`
  * In your browser, go to **URL**/index.txt, where **URL** is the route assigned to your application from Step 5. Using the example from Step 5, this would be `hello-app-test-commutual-seiche.mybluemix.net/index.txt`.
  * (Optional) If you have `curl` installed, you can run curl against the URL. You should see curl return the text "Hello, Bluemix World 1".

        `curl URL/index.txt`
7. Make a change to the `index.txt` file in the sample application.
  * Change the text "Hello, Bluemix World **1**" to "Hello, Bluemix World **2**".

8. Publish the second version of the sample application to Bluemix. This time, use this command:

    `cf push hello_app_2 --no-route`

    Notice the new name (`hello_app_2`), and the option `--no-route`, which tells Bluemix not to assign a route to the application (this overrides the request for a random route in the file `manifest.yml`).

**After completing these steps, you have:**
1. Cloned a repository using `git`.
2. Deployed a sample application to Bluemix using the `cf push` command.
3. Used the `cf app` command to check the status of the deployed application, and used the browser to verify the application is running properly.
4. Made changes to the sample application and re-deployed it to Bluemix.

You are now ready to being your first deployment using the Active Deploy service!

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

# Lab 3: Manual Progression Deployment with the Active Deploy Dashboard

This lab explores the manual progression deployment, and how it differs from an automatic deployment.

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

# Lab 4: Rollback a Deployment with the Active Deploy Dashboard

This lab explores how to roll back a deployment after you have determined there is an issue with the new version of your application.

1. Make a change to the `index.txt` file in the sample application.
  * Change the text "**Hello,** Bluemix World **4**" to "**TYPO in** Bluemix World **5**".

2. Use the CloudFoundry command line to publish the fifth version of the sample application to Bluemix. Run the following command in your terminal/command prompt:

    `cf push hello_app_5 --no-route`

    Notice the new name (`hello_app_5`), and the option `--no-route`, which tells Bluemix not to assign a route to the application.

3. Use the Active Deploy Dashboard to create a new deployment, with custom options to specify phase durations and name for the deployment.

  * Go to the Bluemix Dashboard and click on the Active Deploy service tile. When the Active Deploy Dashboard loads, click on the `Create New Deployment` button.
  * Under the `Select Current Version` section, select `hello_app_4`. The `Select New Version` section will populate with application choices based on your Current Version selection.
  * Under the `Select New Version` section, select `hello_app_5`.
  * Assign the deployment the name of `rollback_lab`.
  * Assign desired durations of 1 minute to the _Ramp-up_ phase, and 1 hour to the _Test_ phase. Note the longer Test phase duration (1 hour).
  * Click the `Create` button to create the new deployment. Upon successful creation, the page will display the details of the new deployment.

  Active Deploy routes traffic to `hello_app_5` and starts ramping up instances.

4. Verify that Bluemix starts routing traffic to both versions.

5. Verify that the deployment has entered the Test phase.

6. We realize there's a typo in `hello_app_5`. Yikes! We can rollback the deployment to its original version. On the deployment details page, we can use the `Rollback` button. On the deployments list page, we can click on the Gear icon of the `rollback_lab` deployment and select the `Rollback` option.

  Rollback the deployment using the `Force Advance` button on the deployment details page. Active Deploy will:
    * Route traffic to `hello_app_4` and ramp up instances (if needed).
    * Stop routing traffic to `hello_app_5`.
    * Reduce the number of instances of `hello_app_5` to 1.

7. Verify that traffic is being routed back to the `hello_app_4` app, and that no traffic is being routed to `hello_app_5`:
  * You can use the `cf apps` command or the Bluemix Dashboard to see all the applications in your Bluemix space. You should see that only `hello_app_4` has an assigned route (the URL from Step 5 in "Creating an Application in Bluemix").
  * In your browser, you can go to **URL**/index.txt, where **URL** is from Step 5 in "Creating an Application in Bluemix". You should only see "Hello, Bluemix World 4".
  * (Optional) If you have `curl` installed, you can run curl against the URL. You should see "Hello, Bluemix World 4".

8. The application has now been rolled back to its original state. You may now delete the `hello_app_5` app using the `cf delete` command:

  `cf delete -f hello_app_5`

**After completing this lab, you have:**
1. Created and deployed a fifth version of the application.
2. Used the `Rollback` button to roll back a deployment.
3. Used a combination of the `cf apps` command, the Bluemix Dashboard, your browser, and/or `curl` to see how the Active Deploy service completes a rollback.
