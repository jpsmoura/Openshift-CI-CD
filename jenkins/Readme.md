# This page describes the openshift ephemeral build which is triggered by a Jenkins job:

1. Login to the Openshift webconsole using the admin user credentials.
2. Create a namespace/project
3. Create a service account and grant edit privileges to the namespace created in step 2
4. Retrieve the OSE Authentication Token of the service account created in step 3
5. Create a sample Secret using the Plugin
6. Start an Openshift build through the pipeline plugin step using the token 
7. Delete the namespace/project and logout

## Notes:

### Step 1
This step is required because the create resources feature of the pipeline plugin doesn't support the creation of a namespace/project. The password is masked on the logs using the Mask Passwords Plugin.

### Step 4
The variables defined in bash scripts aren't visible between the different build steps. In order to expose the OSE_TOKEN variable, the scripts are writing it to a file which is then injected as an Environment variable through the plugin Environment Injector Plugin.
