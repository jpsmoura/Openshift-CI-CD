# Deploy the application
1) Overwrites the application secret. All the properties under ose-secrets are added to the secret.<br />
2) Deployment of the application to OpenShift

## Run the deployment script
git clone https://github.com/jpsmoura/Openshift-CI-CD.git &&
cd Openshift-CI-CD/deployment-scripts/ &&
chmod +x deploy.sh &&
./deploy.sh -u admin -p admin -e DEV -o 10.1.2.2:8443 -n test4 -s my-secret -a s2i-quickstart-cdi-camel

###Script parameters
-u or --user
-p or --password
-e or --environment  --> DEV,TEST,PROD
-o or --osehost
-n or --namespace
-s or --secret
-a or --appname
