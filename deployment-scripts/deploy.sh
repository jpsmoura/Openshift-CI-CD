# Variables to export
USER_NAME=admin
USER_PASSWD=admin
OSE_SERVER=10.1.2.2:8443
CERT_PATH=
APP_NAME=s2i-quickstart-cdi-camel
APP_NAMESPACE=test4
SECRET_NAME=my-secret

oc login -u$USER_NAME -p$USER_PASSWD --server=$OSE_SERVER #--certificate-authority=$CERT_PATH

oc project $APP_NAMESPACE

oc get secrets | grep $SECRET_NAME

if ! [ $? -eq 0 ]; then
  echo -e "Creating new secret: $SECRET_NAME"
  oc secrets new $SECRET_NAME ../ose-secrets
else
  echo -e "Deleting existing secret: $SECRET_NAME"
  oc delete secret $SECRET_NAME
  echo -e "Creating new secret: $SECRET_NAME"
  oc secrets new $SECRET_NAME ../ose-secrets
fi

# App Deployment
echo -e "Deploying Application: $APP_NAME"
oc deploy $APP_NAME --latest
