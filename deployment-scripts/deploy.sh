#!/usr/bin/env bash

while [[ $# -gt 1 ]]
do
key="$1"

case $key in
    -u|--user)
    USER_NAME="$2"
    shift # past argument
    ;;
    -p|--password)
    USER_PASSWD="$2"
    shift # past argument
    ;;
    -e|--environment)
    ENV="$2"
    shift # past argument
    ;;
    -o|--osehost)
    OSE_SERVER="$2"
    shift # past argument
    ;;
    -n|--namespace)
    APP_NAMESPACE="$2"
    shift # past argument
    ;;
    -s|--secret)
    SECRET_NAME="$2"
    shift # past argument
    ;;
    -a|--appname)
    APP_NAME="$2"
    shift # past argument
    ;;
    *)
    echo -e $RED"Illegal parameters: -$OPTARG"$WHITE
    echo -e $RED"Example: ./deploy.sh -u admin -p admin -e DEV -o 10.1.2.2:8443 -n test4 -s my-secret -a s2i-quickstart-cdi-camel"$WHITE
    ;;
esac
shift # past argument or value
done

oc login -u$USER_NAME -p$USER_PASSWD --server=$OSE_SERVER #--certificate-authority=$CERT_PATH

oc project $APP_NAMESPACE

oc get secrets | grep $SECRET_NAME

if ! [ $? -eq 0 ]; then
  echo -e "Creating new secret: $SECRET_NAME"
  oc secrets new $SECRET_NAME ../environments/$ENV/ose-secrets
else
  echo -e "Deleting existing secret: $SECRET_NAME"
  oc delete secret $SECRET_NAME
  echo -e "Creating new secret: $SECRET_NAME"
  oc secrets new $SECRET_NAME ../environments/$ENV/ose-secrets
fi

# App Deployment
echo -e "Deploying Application: $APP_NAME"
oc deploy $APP_NAME --latest
