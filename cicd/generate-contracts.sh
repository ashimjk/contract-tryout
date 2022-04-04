#!/bin/sh

SCRIPT_DIR="$(cd "$(dirname "${0}")" && pwd)"
SCRIPT_DIR="$(dirname ${SCRIPT_DIR})"
cd $SCRIPT_DIR

echo "------------BEGIN: GENERATE------------"

. ./cicd/configs/common.config
sh ./cicd/utils/directory.sh working-dir-create
sh ./cicd/utils/directory.sh contract-output-dir-create

modules=$(sh ./cicd/modules.sh)
for module in $modules; do
  echo "Generating config for module: ${module}\n"
  sh ./cicd/contract-generator/server.sh $module
  sh ./cicd/contract-generator/server-client.sh $module
  sh ./cicd/contract-generator/web-client.sh $module
done

echo "\nGenerate contract"
openapi-generator-cli batch --clean --fail-fast ${WORKING_DIR}/*.yaml

sh ./cicd/utils/directory.sh working-dir-remove

echo "------------SUCCESS: GENERATE------------"
