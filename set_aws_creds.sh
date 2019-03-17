#!/bin/bash
# -----------------------------------------------------------
# Retrieve credentials for the specified COS service key 
# Parameter: <COS_SERVICE_KEY> - default value: COS-HMAC-Key
# 
# To obtain a list of currently defined service keys run
#  ibmcloud resource service-keys
# ------------------------------------------------------------
#set -x

COS_SERVICE_KEY_NAME=$1

if [ "$COS_SERVICE_KEY_NAME" == "" ]; then
    # assign default value
    COS_SERVICE_KEY_NAME=COS-HMAC-Key
fi

# captures STDOUT from the "ibmcloud resource service-key" command 
WORK_FILE=cos-service-key.out

ibmcloud resource service-key "$COS_SERVICE_KEY_NAME" > $WORK_FILE
if [ $? -eq 0 ]; then
  # extract AWS access key id and secret access key
  AWS_ACCESS_KEY_ID=`cat $WORK_FILE | grep 'access_key_id:' | awk '{print $2}'`
  AWS_SECRET_ACCESS_KEY=`cat $WORK_FILE | grep 'secret_access_key:' | awk '{print $2}'` 
  if [ -z "{$AWS_ACCESS_KEY_ID}" ] || [ -z "${AWS_SECRET_ACCESS_KEY}" ]; then
    echo "Error: $COS_SERVICE_KEY_NAME is not a COS service key or does not contain HMAC keys." 
  else 
   echo Set the following environment variables to configure connectivity to your COS service instance:
   echo export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
   echo export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
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
fi  