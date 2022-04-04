#!/bin/sh

TEMP_CONFIG_FILE=${1}
MODULE_CONFIG_FILE=${2}
OUTPUT_CONFIG_FILE=${3}

merge_generator_config() {
  echo "- Merge and create new generator config"
  yq eval-all '. as $item ireduce ({}; . *+ $item)' \
    ${TEMP_CONFIG_FILE} \
    ${MODULE_CONFIG_FILE} >${OUTPUT_CONFIG_FILE}
}

merge_generator_config
