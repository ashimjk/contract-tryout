#!/bin/sh

ARTIFACTS_DIR=artifacts

clear_artifacts_directory() {
  rm -rf ${ARTIFACTS_DIR}
}

create_artifacts_directory() {
  echo "Creating artifacts directory"
  clear_artifacts_directory
  mkdir ${ARTIFACTS_DIR}
}

COMMAND=${1:-config}

if [ X"$COMMAND" = X"create" ]; then
  create_artifacts_directory

elif [ X"$COMMAND" = X"clear" ]; then
  clear_artifacts_directory

else
  echo ${ARTIFACTS_DIR}
fi
