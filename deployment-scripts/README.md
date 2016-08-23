# Deploy the application
1) Overwrites the application secret. All the properties under ose-secrets are added to the secret.<br />
2) Deployment of the application to OpenShift

## Run the deployment script
git clone https://github.com/jpsmoura/Openshift-CI-CD.git <br /> &&
cd deployment-scripts/ <br /> &&
chmod +x deploy.sh <br /> &&
./deploy.sh

###Script parameters
USER_NAME=admin<br/>
USER_PASSWD=admin<br/>
OSE_SERVER=10.1.2.2:8443<br/>
CERT_PATH=<br/>
APP_NAME=s2i-quickstart-cdi-camel<br/>
APP_NAMESPACE=test4<br/>
SECRET_NAME=my-secret<br/>
