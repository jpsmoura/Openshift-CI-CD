# Create 3 different Namespaces/environments
dev,test,prod
# dev Namespace/Environment
oc process -n dev -f build-template.json -v GIT_REPO=https://github.com/bibryam/fis-example.git | oc create -f -  <br />
oc process -n dev -f deployment-template.json -v TAG_NAME=dev | oc create -f -  <br />
# All other Namespace/Environment (test,prod)
oc process -n test -f deployment-template.json -v TAG_NAME=test | oc create -f -  <br />
oc process -n prod -f deployment-template.json -v TAG_NAME=prod | oc create -f -  <br />
Note: Build config is not executed for these environment since we are only building the image once on the dev environment
