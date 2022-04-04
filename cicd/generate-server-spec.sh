#!/bin/sh

WORKING_DIR=$(sh ./cicd/util/working-dir.sh config)
MODULE_NAME=${1}
GENERATOR=${2}

CONTRACT_DIR=$(sh ./cicd/util/config.sh contract-dir)
CONTRACT_OUTPUT_DIR=$(sh ./cicd/util/config.sh contract-output-dir)
BASE_PACKAGE=$(sh ./cicd/util/config.sh server-base-package)
SERVER_SPEC_LOCATION=$(sh ./cicd/util/config.sh server-spec-location $MODULE_NAME)

SPEC_FILE=${WORKING_DIR}/${MODULE_NAME}-${GENERATOR}.yaml
MODULE_CONTRACT=${CONTRACT_DIR}/${MODULE_NAME}
BASE_PACKAGE_WITH_MODULE_NAME=${BASE_PACKAGE}.${MODULE_NAME}

create_server_spec() {
  echo "- Creating common server spec : [${SPEC_FILE}]"
  cat >${SPEC_FILE} <<EOF
'!include': '../${CONTRACT_DIR}/common/spring-boot.yaml'
inputSpec: '${MODULE_CONTRACT}/spec/index.yaml'
outputDir: '${CONTRACT_OUTPUT_DIR}/${MODULE_NAME}/server'
apiPackage: '${BASE_PACKAGE_WITH_MODULE_NAME}.api'
modelPackage: '${BASE_PACKAGE_WITH_MODULE_NAME}.model'
invokerPackage: '${BASE_PACKAGE_WITH_MODULE_NAME}.api.invoker'
EOF
}

merge_server_spec() {
  echo "- Merge and create module spec using server spec"
  yq eval-all '. as $item ireduce ({}; . *+ $item)' ${SPEC_FILE} ${MODULE_CONTRACT}/server.yaml >${SERVER_SPEC_LOCATION}
}

echo "Create common server spec and merge with module spec"
create_server_spec
merge_server_spec
