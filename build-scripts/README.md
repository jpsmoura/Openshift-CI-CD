# Build the application
In this example we are fetching a release bundle from Nexus and include it inside the Docker image on build <br /> time. To accomplish this, the file under .s2i/bin/assemble has been update to call the function get_from_nexus.
## Run the build script
git clone https://github.com/jpsmoura/Openshift-CI-CD.git &&
cd Openshift-CI-CD/build-scripts/ &&
chmod +x build.sh &&
./build.sh -u admin -p admin -o 10.1.2.2:8443 -n test4 -a s2i-quickstart-cdi-camel -u http://localhost:8081/ -g /com/jpmoura/ -i app -v 1.0

###Script parameters
-u or --user<br/>
-p or --password<br/>
-o or --osehost<br/>
-n or --namespace<br/>
-a or --appname<br/>
-u or --nexusURL<br/>
-g or --groupID<br/>
-i or --artifactID<br/>
-v or --version
