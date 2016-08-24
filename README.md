# Openshift CI/CD
In this example, we are setting up a custom CI/CD pipeline for OpenShift<br/><br/>
1) Build - OpenShift takes a release artefact from Nexus Repository and builds a Docker image<br/><br/>
2) Deploy - Deploy the application into DEV; Configuration management - Currently we only have properties files stored as secrets<br/><br/>
3) Promote - Promote dev code to other environments e.g test,prod and apply configuration management
