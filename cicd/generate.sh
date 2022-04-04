#!/bin/sh

set -e

echo "------------BEGIN: GENERATE------------"

sh ./cicd/util/working-dir.sh create
sh ./cicd/util/artifacts-dir.sh create

modules=$(sh ./cicd/modules.sh)
for module in $modules; do
  echo "Generating code for module: ${module}\n"
  sh ./cicd/generate-server-spec.sh $module server
  sh ./cicd/generate-contract.sh $module
done

echo "------------SUCCESS: GENERATE------------"
