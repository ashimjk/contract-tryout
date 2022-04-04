#!/bin/sh

. ./cicd/configs/common.config

clear_directory() {
  rm -rf ${1}
}

create_directory() {
  echo "Creating ${1} directory"
  clear_directory ${1}
  mkdir ${1}
}

COMMAND=${1}

if [ X"$COMMAND" = X"working-dir-create" ]; then
  create_directory $WORKING_DIR

elif [ X"$COMMAND" = X"working-dir-remove" ]; then
  clear_directory $WORKING_DIR

elif [ X"$COMMAND" = X"contract-output-dir-create" ]; then
  create_directory $CONTRACT_OUTPUT_DIR

elif [ X"$COMMAND" = X"remove" ]; then
  clear_directory ${2}

fi
