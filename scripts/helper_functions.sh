#!/usr/bin/env bash

###
# #%L
# GarethHealy :: JBoss Fuse Setup :: Scaffolding Scripts
# %%
# Copyright (C) 2013 - 2015 Gareth Healy
# %%
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# #L%
###

# Set colours
GREEN="\e[32m"
RED="\e[41m\e[37m\e[1m"
YELLOW="\e[33m"
WHITE="\e[0m"

# Openshift Login
function openshift_login()
{
	echo -e $GREEN"Logging into openshift with user $USER_NAME"$WHITE
  oc login -u$USER_NAME -p$USER_PASSWD --server=$OSE_SERVER
}

function update_secrets()
{
  oc get secrets | grep $SECRET_NAME

  if ! [ $? -eq 0 ]; then
    echo -e "Creating new secret: $SECRET_NAME"
    oc secrets new $SECRET_NAME ../environments/$APP_NAMESPACE/ose-secrets
  else
    echo -e "Deleting existing secret: $SECRET_NAME"
    oc delete secret $SECRET_NAME
    echo -e "Creating new secret: $SECRET_NAME"
    oc secrets new $SECRET_NAME ../environments/$APP_NAMESPACE/ose-secrets
  fi
}

function update_configMaps()
{
	echo -e "TODO"
}
