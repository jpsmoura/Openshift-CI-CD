#!/usr/bin/env bash

. ./helper_functions.sh

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
    echo -e $RED"Example: ./deploy.sh -u admin -p admin -e DEV -o 10.1.2.2:8443 -n test4"$WHITE
    ;;
esac
shift # past argument or value
done

openshift_login
# Update secrets on target environment
oc project $ENV
update_secrets
# Tags will always be from the dev namespace
oc project dev
oc tag $APP_NAME:latest $APP_NAME:$ENV
