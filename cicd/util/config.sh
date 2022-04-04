#!/bin/sh

WORKING_DIR=temp
CONTRACT_DIR=contract
CONTRACT_OUTPUT_DIR=artifacts

SERVER_BASE_PACKAGE=com.ashimjk.contract

COMMAND=${1:-config}

if [ X"$COMMAND" = X"working-dir" ]; then
  echo ${WORKING_DIR}

elif [ X"$COMMAND" = X"contract-dir" ]; then
  echo ${CONTRACT_DIR}

elif [ X"$COMMAND" = X"contract-output-dir" ]; then
  echo ${CONTRACT_OUTPUT_DIR}

elif [ X"$COMMAND" = X"server-base-package" ]; then
  module_name=${2}
  echo ${SERVER_BASE_PACKAGE}.${module_name}

elif [ X"$COMMAND" = X"contract-location" ]; then
  module_name=${2}
  echo ${CONTRACT_DIR}/${module_name}

elif [ X"$COMMAND" = X"server-spec-output-file" ]; then
  module_name=${2}
  echo ${WORKING_DIR}/${module_name}.yaml

fi
