#!/bin/sh

WORKING_DIR=temp
CONTRACT_DIR=contract
CONTRACT_OUTPUT_DIR=artifacts

SERVER_BASE_PACKAGE=com.ashimjk.contract

COMMAND=${1:-config}

if [ X"$COMMAND" = X"contract-dir" ]; then
  echo ${CONTRACT_DIR}

elif [ X"$COMMAND" = X"contract-output-dir" ]; then
  echo ${CONTRACT_OUTPUT_DIR}

elif [ X"$COMMAND" = X"server-base-package" ]; then
  echo ${SERVER_BASE_PACKAGE}

elif [ X"$COMMAND" = X"server-base-package" ]; then
  echo ${SERVER_BASE_PACKAGE}

elif [ X"$COMMAND" = X"server-spec-location" ]; then
  module_name=${2}
  server_output_suffix=-final.yaml
  echo ${WORKING_DIR}/${module_name}${server_output_suffix}

fi
