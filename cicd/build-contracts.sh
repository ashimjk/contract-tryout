#!/bin/sh

SCRIPT_DIR="$(cd "$(dirname "${0}")" && pwd)"
SCRIPT_DIR="$(dirname ${SCRIPT_DIR})"
cd $SCRIPT_DIR

CACHE_NPM_MODULES=""

exit_if_error_found() {
  if [ $? -ne 0 ]; then
    exit $?
  fi
}

maven_build() {
  echo "\n\n=================================================================="
  echo "Building contract for module: ${module} - ${1}"
  echo "=================================================================="

  cd $SCRIPT_DIR/${CONTRACT_OUTPUT_DIR}/${module}/$1
  mvn source:jar-no-fork install -DskipTests
  exit_if_error_found
}

cache_node_modules() {
  if [ ! X"$CACHE_NPM_MODULES" = X"" ]; then
    cp -R $CACHE_NPM_MODULES/node_modules $1
    cp -R $CACHE_NPM_MODULES/package-lock.json $1

  else
    echo "Installing node modules\n"
    npm install
    CACHE_NPM_MODULES=$module_path
  fi
}

npm_build() {
  echo "\n\n=================================================================="
  echo "Building contract for module: ${module} - ${1}"
  echo "=================================================================="

  module_path=$SCRIPT_DIR/${CONTRACT_OUTPUT_DIR}/${module}/$1
  cd $module_path
  cache_node_modules $module_path
  npm run build
  exit_if_error_found
}

echo "------------BEGIN: BUILD CONTRACT------------"

. ./cicd/configs/common.config

modules=$(sh ./cicd/modules.sh)
for module in $modules; do
  maven_build ${SERVER_GENERATOR_TYPE}
  maven_build ${SERVER_CLIENT_GENERATOR_TYPE}
  npm_build ${WEB_CLIENT_GENERATOR_TYPE}
done

echo "------------SUCCESS: BUILD CONTRACT------------"
#
