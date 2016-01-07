[![Deploy to Bluemix](https://bluemix.net/deploy/button.png)](https://bluemix.net/deploy?repository=https://github.com/IBM-Bluemix/active-deploy-lab)

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
