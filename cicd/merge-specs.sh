#!/bin/sh

SCRIPT_DIR="$(cd "$(dirname "${0}")" && pwd)"
SCRIPT_DIR="$(dirname ${SCRIPT_DIR})"
cd $SCRIPT_DIR

create_openapi_merge_config() {
  cat >${OPENAPI_MERGE_CONFIG_LOCATION} <<EOF
output: ../${DOCS_API_SPEC_FILE_LOCATION}
inputs:
  - inputFile: ../cicd/configs/api-contract.yaml
EOF
}

append_spec_location_to_config() {
  MODULE_NAME=$1
  . ./cicd/configs/common.config
  echo "  - inputFile: ../${DOCS_SPEC_FILE_LOCATION}" >>${OPENAPI_MERGE_CONFIG_LOCATION}
}

merge_spec() {
  npx openapi-merge-cli --config ${OPENAPI_MERGE_CONFIG_LOCATION}
}

echo "------------BEGIN: MERGE SPECS------------"

. ./cicd/configs/common.config
sh ./cicd/utils/directory.sh working-dir-create

create_openapi_merge_config

modules=$(sh ./cicd/modules.sh)
for module in $modules; do
  append_spec_location_to_config $module
done

merge_spec
sh ./cicd/utils/directory.sh working-dir-remove

echo "------------SUCCESS: MERGE SPECS----------"
#
