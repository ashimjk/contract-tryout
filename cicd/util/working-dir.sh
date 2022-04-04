#!/bin/sh

WORKING_DIR=temp

clear_working_directory() {
  rm -rf ${WORKING_DIR}
}

create_working_directory() {
  echo "Creating working directory"
  clear_working_directory
  mkdir ${WORKING_DIR}
}

COMMAND=${1:-config}

if [ X"$COMMAND" = X"create" ]; then
  create_working_directory

elif [ X"$COMMAND" = X"clear" ]; then
  clear_working_directory

else
  echo ${WORKING_DIR}
fi
