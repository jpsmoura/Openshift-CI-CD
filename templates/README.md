# Create 3 different Namespaces/environments
dev,test,prod
# dev Namespace/Environment
oc process -f build-template.json -v GIT_REPO=https://github.com/jpsmoura/fis-example.git | oc create -n dev -f -  <br />
oc process -f deployment-template.json -v ENV=dev -v SECRET_NAME=my-secret | oc create -n dev -f -  <br />
# All other Namespace/Environment (test,prod)
oc process -f deployment-template.json -v ENV=test -v SECRET_NAME=my-secret | oc create -n test -f - <br />
oc process -f deployment-template.json -v ENV=prod -v SECRET_NAME=my-secret | oc create -n prod -f - <br />
Note: Build config is not executed for these environment since we are only building the image once on the dev environment
