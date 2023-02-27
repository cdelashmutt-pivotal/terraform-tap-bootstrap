#!/bin/bash

STARTING_DIR=${1:-catalog}
TERRAFORM_OUTPUT=$(terraform output -state=terraform/terraform.tfstate -json)
STORAGE_ACCOUNT=$(jq -r .storage_account.value <<< "$TERRAFORM_OUTPUT")
STORAGE_ACCOUNT_CONTAINER=$(jq -r .storage_account_container.value <<< "$TERRAFORM_OUTPUT")
STORAGE_ACCOUNT_KEY=$(jq -r .storage_account_key.value <<< "$TERRAFORM_OUTPUT")

find $STARTING_DIR -type f -name \*.yaml -print0 | while IFS= read -r -d '' file
do 
  if grep "backstage.io/techdocs-ref" $file; then
    rm -rf /tmp/site
    SOURCE_DIR=$(dirname $file)
    NAMESPACE=$(yq '.metadata.namespace // "default"' $file)
    KIND=$(yq '.kind' $file | tr '[:upper:]' '[:lower:]')
    NAME=$(yq '.metadata.name' $file)
    npx @techdocs/cli generate --source-dir $SOURCE_DIR --output-dir /tmp/site
    npx @techdocs/cli publish --publisher-type azureBlobStorage --storage-name $STORAGE_ACCOUNT_CONTAINER --entity $NAMESPACE/$KIND/$NAME --directory /tmp/site --azureAccountName $STORAGE_ACCOUNT --azureAccountKey $STORAGE_ACCOUNT_KEY
  fi
done