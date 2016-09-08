oc login --insecure-skip-tls-verify -uadmin -p${ADMIN_PWD} --server=10.1.2.2:8443
oc new-project ${PROJECT_NAME}

oc create sa jenkins -n ${PROJECT_NAME}
oc adm policy add-role-to-user edit -z jenkins -n ${PROJECT_NAME}

OSE_TOKEN=$(oc get sa/jenkins -n ${PROJECT_NAME} --template='{{range .secrets}}{{ .name }} {{end}}' | xargs -n 1 oc get secret --template='{{ if .data.token }}{{ .data.token }}{{end}}' | head -n 1 | base64 -D -)
echo "OSE_TOKEN=$OSE_TOKEN" > env_start.txt

oc process -f ../templates/dev-contacts.json | oc create -n ${PROJECT_NAME} -f - 
