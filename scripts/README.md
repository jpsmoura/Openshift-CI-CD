# Build the application
In this example, we are triggering a custom Openshift s2i build. As part of the docker image creation, we are fetching a release bundle from Nexus and adding it to the container. <br /> To accomplish this, the file under .s2i/bin/assemble has been updated to call the function get_from_nexus.

### Run the build script
git clone https://github.com/jpsmoura/Openshift-CI-CD.git &&
cd Openshift-CI-CD/scripts/ &&
chmod +x build.sh &&
./build.sh -u admin -p admin -o 10.1.2.2:8443 -n test4 -a s2i-quickstart-cdi-camel -u http://localhost:8081/ -g /com/jpmoura/ -i app -v 1.0

#### Script Parameters
-u or --user<br/>
-p or --password<br/>
-o or --osehost<br/>
-n or --namespace<br/>
-a or --appname<br/>
-u or --nexusURL<br/>
-g or --groupID<br/>
-i or --artifactID<br/>
-v or --version

### This example
We haven't created a Nexus instance for this example, as a replacement, Dropbox is being used to store a sample release bundle.<br/>
In order to remove this hardcoded link please comment line 120 on the assemble script.


# Deployment of the application
1) Overwrites the application secret. All the properties under ose-secrets are added to the secret.<br/>
2) Application is deployed to OpenShift

### Run the deployment script
git clone https://github.com/jpsmoura/Openshift-CI-CD.git &&
cd Openshift-CI-CD/scripts/ &&
chmod +x deploy.sh &&
./deploy.sh -u admin -p admin -e DEV -o 10.1.2.2:8443 -n test4 -s my-secret -a s2i-quickstart-cdi-camel

#### Script parameters
-u or --user<br/>
-p or --password<br/>
-e or --environment --> DEV,TEST,PROD<br/>
-o or --osehost<br/>
-n or --namespace<br/>
-s or --secret<br/>
-a or --appname<br/>

### Environment Customisation
Simply copy one of the environments folders and rename it to the name of your new environment

### Environment Promotion
To promote between environments we are using the image change trigger mechanism. Once the images are tagged the deployment process kicks off automatically.<br/>

e.g. <br/>
./promotion.sh -u admin -p admin -e prod -o 10.1.2.2:8443 -a s2i-quickstart-cdi-camel
