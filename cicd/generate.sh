#!/bin/sh

echo "------------BEGIN: GENERATE------------"

sh ./cicd/util/directory.sh working-dir-create
sh ./cicd/util/directory.sh contract-output-dir-create

modules=$(sh ./cicd/modules.sh)
for module in $modules; do
  echo "Generating code for module: ${module}\n"
  sh ./cicd/generator/generate-server-spec.sh $module server
  sh ./cicd/generator/generate-contract.sh $module
done

echo "------------SUCCESS: GENERATE------------"
