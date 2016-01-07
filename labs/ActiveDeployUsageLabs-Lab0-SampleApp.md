[![Deploy to Bluemix](https://bluemix.net/deploy/button.png)](https://bluemix.net/deploy?repository=https://github.com/IBM-Bluemix/active-deploy-lab)

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
