#!/bin/sh

echo "------------BEGIN: GENERATE------------"

. ./cicd/configs/common.config
sh ./cicd/utils/directory.sh working-dir-create
sh ./cicd/utils/directory.sh contract-output-dir-create

modules=$(sh ./cicd/modules.sh)
for module in $modules; do
  echo "Generating code for module: ${module}\n"
  sh ./cicd/generator/server-contract.sh $module
  sh ./cicd/generator/server-client-contract.sh $module
  sh ./cicd/generator/web-client-contract.sh $module
done

echo "\nGenerate contract"
openapi-generator-cli batch --clean --fail-fast ${WORKING_DIR}/*.yaml

sh ./cicd/utils/directory.sh working-dir-remove

echo "------------SUCCESS: GENERATE------------"
