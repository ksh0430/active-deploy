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

    `cf push hello_app_1 -s cflinuxfs2 -i 2`

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

    `cf push hello_app_2 -s cflinuxfs2 --no-route`

    Notice the new name (`hello_app_2`), and the option `--no-route`, which tells Bluemix not to assign a route to the application (this overrides the request for a random route in the file `manifest.yml`).

**After completing these steps, you have:**
1. Cloned a repository using `git`.
2. Deployed a sample application to Bluemix using the `cf push` command.
3. Used the `cf app` command to check the status of the deployed application, and used the browser to verify the application is running properly.
4. Made changes to the sample application and re-deployed it to Bluemix.

You are now ready to being your first deployment using the Active Deploy service!


# Lab 1: Default Deployment

This lab will show us how to get started using Active Deploy quickly by doing an automated deployment using a default configuration.

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

# Lab 2: Custom Deployment

This lab will show us the customizability of Active Deploy by passing command line arguments when creating our deployments.

1. Make a change to the `index.txt` file in the sample application.
  * Change the text "Hello, Bluemix World **2**" to "Hello, Bluemix World **3**".

2. Use the CloudFoundry command line to publish the third version of the sample application to Bluemix. Run the following command in your terminal/command prompt:

    `cf push hello_app_3 -s cflinuxfs2 --no-route`

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

# Lab 3: Manual Progression Deployment

This lab explores the manual progression deployment, and how it differs from an automatic deployment.

1. Make a change to the `index.txt` file in the sample application.
  * Change the text "Hello, Bluemix World **3**" to "Hello, Bluemix World **4**".

2. Use the CloudFoundry command line to publish the fourth version of the sample application to Bluemix. Run the following command in your terminal/command prompt:

    `cf push hello_app_4 -s cflinuxfs2 --no-route`

    Notice the new name (`hello_app_4`), and the option `--no-route`.

3. Use the `cf active-deploy-create` command to create a new deployment, with custom options to specify custom phase durations, a custom label, and a manual progression deployment.

    `cf active-deploy-create hello_app_3 hello_app_4 --manual --label manual_lab --rampup 1m --test 1m --rampdown 1m`

    Active Deploy routes traffic to `hello_app_4` and starts ramping up instances.

4. List the deployments of the Active Deploys service using the `cf active-deploy-list` command:

    `cf active-deploy-list`

    When the phase is _rampup_:
      * `cf apps` should show both that `hello_app_2` and `hello_app_3` are assigned the same route.
      * Reloading your browser should show both responses "Hello, Bluemix World 2" and "Hello, Bluemix World 3"
      * Queries using `curl` should return both "Hello, Bluemix World 2" and "Hello, Bluemix World 3".

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

# Lab 4: Rollback a Deployment

This lab explores how to roll back a deployment after you have determined there is an issue with the new version of your application.

1. Make a change to the `index.txt` file in the sample application.
  * Change the text "**Hello,** Bluemix World **4**" to "**TYPO in** Bluemix World **5**".

2. Use the CloudFoundry command line to publish the fifth version of the sample application to Bluemix. Run the following command in your terminal/command prompt:

    `cf push hello_app_5 -s cflinuxfs2 --no-route`

    Notice the new name (`hello_app_5`), and the option `--no-route`, which tells Bluemix not to assign a route to the application.

3. Use the `cf active-deploy-create` command to create a new deployment, with custom options to specify custom phase durations and a custom label.

    `cf active-deploy-create hello_app_4 hello_app_5 --label rollback_lab --rampup 1m --test 1h`

    Note the longer Test phase duration (`1h`). Active Deploy routes traffic to `hello_app_5` and starts ramping up instances.

4. Verify that Bluemix starts routing traffic to both versions.

5. Verify that the deployment has entered the Test phase.

6. We realize there's a typo in `hello_world_5`. Yikes! We can rollback the deployment to its original version by using the `cf active-deploy-rollback` command:

    `cf active-deploy-rollback rollback_lab`

    Active Deploy will:
    * Route traffic to `hello_app_4` and ramp up instances (if needed).
    * Stop routing traffic to `hello_app_5`.
    * Reduce the number of instances of `hello_app_5` to 1.

7. Verify that traffic is being routed back to the `hello_world_4` app, and that no traffic is being routed to `hello_world_5`:
    * You can use the `cf apps` command to list all the applications in your Bluemix space. You should see that only `hello_app_4` has an assigned route (the URL from Step 5 in "Creating an Application in Bluemix").
    * In your browser, you can go to **URL**/index.txt, where **URL** is from Step 5 in "Creating an Application in Bluemix". You should only see "Hello, Bluemix World 4".
    * (Optional) If you have `curl` installed, you can run curl against the URL. You should see "Hello, Bluemix World 4".

8. The application has now been rolled back to its original state. You may now delete the `hello_world_5` app using the `cf delete` command:

    `cf delete -f hello_world_5`

**After completing this lab, you have:**
1. Created and deployed a fifth version of the application.
2. Used the `cf active-deploy-rollback` command to roll back a deployment.
3. Used a combination of the `cf apps` command, your browser, and/or `curl` to see how the Active Deploy service completes a rollback.
