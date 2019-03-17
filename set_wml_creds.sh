#!/bin/bash
# --------------------------------------------------------
# Retrieve credentials for the specified WML service key 
# Parameter: <WML_SERVICE_KEY> - default value: WML-Key
# 
# To obtain a list of currently defined service keys run
#  ibmcloud resource service-keys
# --------------------------------------------------------

WML_SERVICE_KEY_NAME=$1

if [ "$WML_SERVICE_KEY_NAME" == "" ]; then
    # assign default value
    WML_SERVICE_KEY_NAME=WML-Key
fi

# captures STDOUT from the "ibmcloud resource service-key" command 
WORK_FILE=wml-service-key.out

ibmcloud resource service-key $WML_SERVICE_KEY_NAME > $WORK_FILE
if [ $? -eq 0 ]; then
  # extract wml instance id, user name, password, and env
  ML_INSTANCE_ID=`cat $WORK_FILE | grep 'instance_id:' | awk '{print $2}'`
  ML_USERNAME=`cat $WORK_FILE | grep 'username:' | awk '{print $2}'`
  ML_PASSWORD=`cat $WORK_FILE | grep 'password:' | awk '{print $2}'`
  ML_ENV=`cat $WORK_FILE | grep 'url:' | awk '{print $2}'` 
  if [ -z "${ML_INSTANCE_ID}" ] || [ -z "${ML_USERNAME}" ] || [ -z "{$ML_PASSWORD}" ] || [ -z "${ML_ENV}" ]; then
    echo "Error: $WML_SERVICE_KEY_NAME is not a WML service key." 
  else 
   echo Set the following environment variables to configure connectivity to your WML service instance:
   echo export ML_INSTANCE=$ML_INSTANCE_ID
   echo export ML_USERNAME=$ML_USERNAME
   echo export ML_PASSWORD=$ML_PASSWORD
   echo export ML_ENV=$ML_ENV
  fi 
else
 # the command returned an error. Display captured STDOUT 
 if [ -f $WORK_FILE ]; then
  cat $WORK_FILE
 fi  
 echo 'To display a list of existing service keys run: ibmcloud resource service-keys'
fi

# cleanup
if [ -f $WORK_FILE ]; then
  rm $WORK_FILE
  echo 
fi  