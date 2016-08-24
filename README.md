# Openshift CI/CD
In this example, we are setting up a custom CI/CD pipeline for OpenShift<br/><br/>
1) Build - OpenShift takes a release artefact from Nexus Repository and builds a Docker image<br/><br/>
2) Deploy - Use the appropriate application properties based on the target environment (DEV,TEST,PROD). The secrets mechanism is being used to store the properties
