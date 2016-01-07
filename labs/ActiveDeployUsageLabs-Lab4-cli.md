[![Deploy to Bluemix](https://bluemix.net/deploy/button.png)](https://bluemix.net/deploy?repository=https://github.com/IBM-Bluemix/active-deploy-lab)

# Lab 4: Rollback a Deployment with the CLI

This lab explores how to roll back a deployment after you have determined there is an issue with the new version of your application.

1. Make a change to the `index.txt` file in the sample application.
  * Change the text "**Hello,** Bluemix World **4**" to "**TYPO in** Bluemix World **5**".

2. Use the CloudFoundry command line to publish the fifth version of the sample application to Bluemix. Run the following command in your terminal/command prompt:

    `cf push hello_app_5 --no-route`

    Notice the new name (`hello_app_5`), and the option `--no-route`, which tells Bluemix not to assign a route to the application.

3. Use the `cf active-deploy-create` command to create a new deployment, with custom options to specify custom phase durations and a custom label.

    `cf active-deploy-create hello_app_4 hello_app_5 --label rollback_lab --rampup 1m --test 1h`

    Note the longer Test phase duration (`1h`). Active Deploy routes traffic to `hello_app_5` and starts ramping up instances.

4. Verify that Bluemix starts routing traffic to both versions.

5. Verify that the deployment has entered the Test phase.

6. We realize there's a typo in `hello_app_5`. Yikes! We can rollback the deployment to its original version by using the `cf active-deploy-rollback` command:

    `cf active-deploy-rollback rollback_lab`

    Active Deploy will:
    * Route traffic to `hello_app_4` and ramp up instances (if needed).
    * Stop routing traffic to `hello_app_5`.
    * Reduce the number of instances of `hello_app_5` to 1.

7. Verify that traffic is being routed back to the `hello_app_4` app, and that no traffic is being routed to `hello_app_5`:
    * You can use the `cf apps` command to list all the applications in your Bluemix space. You should see that only `hello_app_4` has an assigned route (the URL from Step 5 in "Creating an Application in Bluemix").
    * In your browser, you can go to **URL**/index.txt, where **URL** is from Step 5 in "Creating an Application in Bluemix". You should only see "Hello, Bluemix World 4".
    * (Optional) If you have `curl` installed, you can run curl against the URL. You should see "Hello, Bluemix World 4".

8. The application has now been rolled back to its original state. You may now delete the `hello_app_5` app using the `cf delete` command:

    `cf delete -f hello_app_5`

**After completing this lab, you have:**
1. Created and deployed a fifth version of the application.
2. Used the `cf active-deploy-rollback` command to roll back a deployment.
3. Used a combination of the `cf apps` command, your browser, and/or `curl` to see how the Active Deploy service completes a rollback.
