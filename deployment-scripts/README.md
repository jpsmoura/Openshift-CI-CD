# Deployment of the application
1) Overwrites the application secret. All the properties under ose-secrets are added to the secret.<br/>
2) Application is deployed to OpenShift

## Run the deployment script
git clone https://github.com/jpsmoura/Openshift-CI-CD.git &&
cd Openshift-CI-CD/deployment-scripts/ &&
chmod +x deploy.sh &&
./deploy.sh -u admin -p admin -e DEV -o 10.1.2.2:8443 -n test4 -s my-secret -a s2i-quickstart-cdi-camel

###Script parameters
-u or --user<br/>
-p or --password<br/>
-e or --environment --> DEV,TEST,PROD<br/>
-o or --osehost<br/>
-n or --namespace<br/>
-s or --secret<br/>
-a or --appname<br/>

## Environment Customisation
Simply copy one of the environments folders and rename it to the name of your new environment
