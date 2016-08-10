# Customise the build of a docker image in Openshift
In this example we are fetching a release bundle from Nexus and include it inside the Docker image on build <br /> time. To accomplish this, the file under .s2i/bin/assemble has been update to call the function get_from_nexus.
# Run the Build with different parameters as input
oc start-build <buildConfig> -n <namespace> --env var=value <br />
If no parameters are given the default values are populated from the environment file.

## Example
oc start-build s2i-quickstart-cdi-camel -n default --env \ <br />
REPOSITORY_NAME=nexus/content/repositories/releases \ <br />
NEXUS_URL=http://localhost:8081/ \ <br />
GROUP_ID=/com/jpmoura/ \ <br />
ARTIFACT_ID=app \ <br />
ARTIFACT_VERSION=1.0

# Run the example from FIS Vagrant Box
git clone https://github.com/jpsmoura/Openshift-CI-CD.git <br />
oc create configmap ci-cd-config --from-file=./config-map.properties
