#!/bin/bash

MODULE_NAME=$1

SERVER_SPEC_LOCATION=$(sh ./cicd/util/config.sh server-spec-location $MODULE_NAME)
#OUTPUT_DIR=$(sh ./cicd/util/config.sh contract-output-dir)

openapi_generate() {
  echo "Generating contract for ${MODULE_NAME}"
  npm run openapi batch ${SERVER_SPEC_LOCATION}
  #  npm run openapi batch contract/${module}/web-client.yaml

  #  SERVER_CLIENT=contract/${module}/server-client.yaml
  #  if [ -f "$SERVER_CLIENT" ]; then
  #    npm run openapi batch $SERVER_CLIENT
  #  fi

  #  moduleContractFile=$(grep 'inputSpec:' contract/${module}/server.yaml | tail -n1 | cut -c 13- | rev | cut -c 2- | rev)
}
#  #  swagger-cli bundle $moduleContractFile -o ${SPEC_OUTPUT_DIR}/${module}.json

openapi_generate

#echo "------------BEGIN: GENERATE------------"
#echo "Current script directory: $SCRIPT_DIR"
#echo "New semantic version: $NEW_VERSION"
#
#for module in \
#  "payroll" \
#  ; do
#    echo "Generating code for module: ${module}"
#    openapi_generate ${module}
#done
#
#echo "------------SUCCESS: GENERATE------------"
