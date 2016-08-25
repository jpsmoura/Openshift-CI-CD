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
    APP_NAMESPACE="$2"
    shift # past argument
    ;;
    -t|--targetenv)
    TARGET_ENV="$2"
    shift # past argument
    ;;
    -o|--osehost)
    OSE_SERVER="$2"
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
    echo -e $RED"Example: ./promotion.sh -u admin -p admin -e dev -t test -o 10.1.2.2:8443"$WHITE
    echo -e $RED"Example: ./promotion.sh -u admin -p admin -e test -t prod -o 10.1.2.2:8443"$WHITE
    ;;
esac
shift # past argument or value
done

openshift_login
# Update secrets on target environment
oc project $TARGET_ENV
update_secrets

oc project dev
oc tag $APP_NAME:$APP_NAMESPACE $APP_NAME:$TARGET_ENV
