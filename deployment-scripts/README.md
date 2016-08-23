# Deploy the application
1) Overwrites the application secret. All the properties under ose-secrets are added to the secret.
2) Deployment of the application to OpenShift

## Run the example from FIS Vagrant Box
git clone https://github.com/jpsmoura/Openshift-CI-CD.git <br />
./deployment-scripts/deploy

###Script parameters
USER_NAME=admin
USER_PASSWD=admin
OSE_SERVER=10.1.2.2:8443
CERT_PATH=
APP_NAME=s2i-quickstart-cdi-camel
APP_NAMESPACE=test4
SECRET_NAME=my-secret
