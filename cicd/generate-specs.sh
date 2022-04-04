#!/bin/sh

SCRIPT_DIR="$(cd "$(dirname "${0}")" && pwd)"
SCRIPT_DIR="$(dirname ${SCRIPT_DIR})"
cd $SCRIPT_DIR

echo "------------BEGIN: GENERATE SPECS------------"

modules=$(sh ./cicd/modules.sh)
for MODULE_NAME in $modules; do
  echo "\nGenerating spec for module: ${MODULE_NAME}"

  . ./cicd/configs/common.config
  swagger-cli bundle ${INPUT_SPEC_LOCATION} -o ${DOCS_SPEC_FILE_LOCATION}
done

echo "------------SUCCESS: GENERATE SPECS------------"
