#!/usr/bin/env bash
git clone https://github.com/jpsmoura/Openshift-CI-CD.git
chmod -R +x *

oc login -uadmin -padmin --server=10.1.2.2:8443
# Create Projects through the web console , authorization issues need to be solved.
#oc create namespace dev
#oc create namespace test
#oc create namespace prod

cd Openshift-CI-CD/templates

oc process -f build-template.json -v GIT_REPO=https://github.com/jpsmoura/Openshift-CI-CD.git | oc create -n dev -f -
oc process -f deployment-template.json -v ENV=dev | oc create -n dev -f -
oc process -f deployment-template.json -v ENV=test | oc create -n test -f -
oc process -f deployment-template.json -v ENV=prod | oc create -n prod -f -

#Build and deploy to dev
cd ../scripts/
./build.sh -u admin -p admin -o 10.1.2.2:8443 -e dev -a s2i-quickstart-cdi-camel -x http://localhost:8081/ -g /com/jpmoura/ -i app -v 1.0
./deploy.sh -u admin -p admin -o 10.1.2.2:8443 -e dev -s my-secret -a s2i-quickstart-cdi-camel

#Promote to test
./promotion.sh -u admin -p admin -e dev -t test -o 10.1.2.2:8443 -a s2i-quickstart-cdi-camel -s my-secret
#Promote to Prod
./promotion.sh -u admin -p admin -e test -t prod -o 10.1.2.2:8443 -a s2i-quickstart-cdi-camel -s my-secret
