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
    -o|--osehost)
    OSE_SERVER="$2"
    shift # past argument
    ;;
    -n|--namespace)
    APP_NAMESPACE="$2"
    shift # past argument
    ;;
    -a|--appname)
    APP_NAME="$2"
    shift # past argument
    ;;
    -x|--nexusURL)
    NEXUS_URL="$2"
    shift # past argument
    ;;
    -g|--groupID)
    MVN_GROUP_ID="$2"
    shift # past argument
    ;;
    -i|--artifactID)
    MVN_ARTIFACT_ID="$2"
    shift # past argument
    ;;
    -v|--version)
    MVN_VERSION="$2"
    shift # past argument
    ;;
    *)
    echo -e $RED"Illegal parameters: -$OPTARG"$WHITE
    echo -e $RED"Example: ./build.sh -u admin -p admin -o 10.1.2.2:8443 -n test4 -a s2i-quickstart-cdi-camel -x https://maven.repository.redhat.com/ga -g /apache-log4j/log4j/ -i app -v 1.2.14"$WHITE
    ;;
    esac
    shift # past argument or value
    done

oc login -u$USER_NAME -p$USER_PASSWD --server=$OSE_SERVER

BUILD_ID=`oc start-build $APP_NAME -n $APP_NAMESPACE --env NEXUS_URL=$NEXUS_URL --env GROUP_ID=$MVN_GROUP_ID --env ARTIFACT_ID=$MVN_ARTIFACT_ID --env ARTIFACT_VERSION=$MVN_VERSION`

echo "Waiting for build to start"
rc=1
attempts=25
count=0
while [ $rc -ne 0 -a $count -lt $attempts ]; do
  status=`oc get build ${BUILD_ID} -t '{{.status.phase}}'`
  if [[ $status == "Failed" || $status == "Error" || $status == "Canceled" ]]; then
    echo "Fail: Build completed with unsuccessful status: ${status}"
    exit 1
  fi
  if [ $status == "Complete" ]; then
    echo "Build completed successfully, will test deployment next"
    rc=0
  fi

  if [ $status == "Running" ]; then
    echo "Build started"
    rc=0
  fi

  if [ $status == "Pending" ]; then
    count=$(($count+1))
    echo "Attempt $count/$attempts"
    sleep 5
  fi
done

# stream the logs for the build that just started
oc build-logs $BUILD_ID

echo "Checking build result status"
rc=1
count=0
attempts=100
while [ $rc -ne 0 -a $count -lt $attempts ]; do
  status=`oc get build ${BUILD_ID} -t '{{.status.phase}}'`
  if [[ $status == "Failed" || $status == "Error" || $status == "Canceled" ]]; then
    echo "Fail: Build completed with unsuccessful status: ${status}"
    exit 1
  fi

  if [ $status == "Complete" ]; then
    echo "Build completed successfully, will test deployment next"
    rc=0
  else
    count=$(($count+1))
    echo "Attempt $count/$attempts"
    sleep 5
  fi
done

if [ $rc -ne 0 ]; then
    echo "Fail: Build did not complete in a reasonable period of time"
    exit 1
fi


echo "Checking build result status"
rc=1
count=0
attempts=100
while [ $rc -ne 0 -a $count -lt $attempts ]; do
  status=`oc get build ${BUILD_ID} -t '{{.status.phase}}'`
  if [[ $status == "Failed" || $status == "Error" || $status == "Canceled" ]]; then
    echo "Fail: Build completed with unsuccessful status: ${status}"
    exit 1
  fi

  if [ $status == "Complete" ]; then
    echo "Build completed successfully, will test deployment next"
    rc=0
  else
    count=$(($count+1))
    echo "Attempt $count/$attempts"
    sleep 5
  fi
done

if [ $rc -ne 0 ]; then
    echo "Fail: Build did not complete in a reasonable period of time"
    exit 1
fi
