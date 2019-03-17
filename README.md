# ibm-cloud-utility-scripts
A random collection of utility scripts for Mac/Linux that simplify IBM Cloud tasks.

## Prerequisites

1. [Install the IBM Cloud CLI](https://cloud.ibm.com/docs/cli?topic=cloud-cli-ibmcloud-cli#overview)


## Watson Machine Learning utility scripts

###  Expose WML service credentials as environment variables

In order to connect to a WML service instance, the [Watson Machine Learning plugin](
https://cloud.ibm.com/docs/machine-learning-cli-plugin?topic=machine-learning-cli-ibm-watson-machine-learning-cli#ibm-watson-machine-learning-cli)  requires that the `ML_ENV`,`ML_USERNAME`, `ML_PASSWORD`, and `ML_INSTANCE` environment variables are defined. Use the `set_wml_creds` script to retrieve the credentials of a pre-configured Watson Machine Learning instance service key.

#### Usage

```
$ set_wml_creds.sh <existing_wml_service_key>
```

#### Example

```
$ ./set_wml_creds.sh WML-Key
 Set the following environment variables to configure connectivity to your WML service instance:
 export ML_INSTANCE=e...5
 export ML_USERNAME=0...9
 export ML_PASSWORD=f...0
 export ML_ENV=https://...
```

#### Notes

An error is returned if:
 - the specified service key is not defined
 - the specified service key exists but is not a WML service key

 ---


 ## Cloud Object Storage


###  Expose HMAC service credentials as environment variables

Use the `set_aws_creds` script to retrieve the HMAC credentials of a pre-configured Cloud Object Storage (COS) instance service key.

#### Usage

```
$ ./set_aws_creds.sh <existing_cos_service_key>
```

#### Example

```
$ ./set_aws_creds.sh obj_hmac
Set the following environment variables to configure connectivity to your COS service instance:
export AWS_ACCESS_KEY_ID=d...f
export AWS_SECRET_ACCESS_KEY=b...5
```

#### Notes

An error is returned if:
 - the specified service key is not defined
 - the specified service key exists but is not a COS service key
 - the specified COS service key does not include HMAC credentials

 ---
