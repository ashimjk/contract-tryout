#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPT_DIR="$(dirname ${SCRIPT_DIR})"
OUTPUT_DIR=artifacts
SPEC_OUTPUT_DIR=${OUTPUT_DIR}/spec

openapi_generate() {
  rm -rf ${OUTPUT_DIR}

  module=$1
  npm run openapi batch contract/${module}/server.yaml
  npm run openapi batch contract/${module}/web-client.yaml

  SERVER_CLIENT=contract/${module}/server-client.yaml
  if [ -f "$SERVER_CLIENT" ]; then
    npm run openapi batch $SERVER_CLIENT
  fi

  moduleContractFile=$(grep 'inputSpec:' contract/${module}/server.yaml | tail -n1 | cut -c 13- | rev | cut -c 2- | rev)
  swagger-cli bundle $moduleContractFile -o ${SPEC_OUTPUT_DIR}/${module}.json
}

echo "------------BEGIN: GENERATE------------"
echo "Current script directory: $SCRIPT_DIR"
echo "New semantic version: $NEW_VERSION"

for module in \
  "payroll" \
  ; do
    echo "Generating code for module: ${module}"
    openapi_generate ${module}
done

echo "------------SUCCESS: GENERATE------------"
