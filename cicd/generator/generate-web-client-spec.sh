#!/bin/sh

MODULE_NAME=${1}
GENERATOR=${2}

WORKING_DIR=$(sh ./cicd/util/config.sh working-dir)
CONTRACT_DIR=$(sh ./cicd/util/config.sh contract-dir)
CONTRACT_LOCATION=$(sh ./cicd/util/config.sh contract-location $MODULE_NAME)
CONTRACT_OUTPUT_DIR=$(sh ./cicd/util/config.sh contract-output-dir)
BASE_PACKAGE=$(sh ./cicd/util/config.sh server-base-package $MODULE_NAME)

SPEC_FILE=${WORKING_DIR}/${MODULE_NAME}-${GENERATOR}.yaml
SPEC_OUTPUT_FILE=$(sh ./cicd/util/config.sh server-spec-output-file $MODULE_NAME)

create_server_spec() {
  echo "- Creating common server spec : [${SPEC_FILE}]"
  cat >${SPEC_FILE} <<EOF
'!include': '../${CONTRACT_DIR}/common/spring-boot.yaml'
inputSpec: '${CONTRACT_LOCATION}/spec/index.yaml'
outputDir: '${CONTRACT_OUTPUT_DIR}/${MODULE_NAME}/server'
apiPackage: '${BASE_PACKAGE}.api'
modelPackage: '${BASE_PACKAGE}.model'
invokerPackage: '${BASE_PACKAGE}.api.invoker'
EOF
}

merge_server_spec() {
  echo "- Merge and create module spec using server spec"
  yq eval-all '. as $item ireduce ({}; . *+ $item)' ${SPEC_FILE} ${CONTRACT_LOCATION}/server.yaml >${SPEC_OUTPUT_FILE}
}

remove_common_server_spec() {
  rm ${SPEC_FILE}
}

echo "Create common server spec and merge with module spec"
create_server_spec
merge_server_spec
remove_common_server_spec
