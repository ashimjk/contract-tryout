#!/bin/sh

MODULE_NAME=${1}

. ./cicd/configs/common.config
. ./cicd/configs/web-client.config

create_generator_config() {
  echo "- Creating generator config"

  cat >${TEMP_GENERATOR_CONFIG_OUTPUT_FILE_LOCATION} <<EOF
'!include': '${GENERATOR_CONFIG_FILE_LOCATION}'
inputSpec: '${INPUT_SPEC_LOCATION}'
outputDir: '${CONTRACT_OUTPUT_LOCATION}'
npmName: '${NPM_PACKAGE_NAME}'
EOF
}

generate_contract() {
  sh ./cicd/utils/merge-generator-config.sh \
    ${TEMP_GENERATOR_CONFIG_OUTPUT_FILE_LOCATION} \
    ${GENERATOR_CONFIG_INPUT_FILE_LOCATION} \
    ${GENERATOR_CONFIG_OUTPUT_FILE_LOCATION}
}

remove_temp_generator_config_file() {
  sh ./cicd/utils/directory.sh remove ${TEMP_GENERATOR_CONFIG_OUTPUT_FILE_LOCATION}
}

echo "\nGenerate Web-Client Contract"
create_generator_config
generate_contract
remove_temp_generator_config_file
