CONTRACT_DIR=contract
MODULE_NAME=payroll
OUTPUT_DIR=artifacts

BASE_PACKAGE=com.ashimjk.contract

cat >${MODULE_NAME}.yml <<EOF
'!include': '../common/spring-boot.yaml'
inputSpec: '${CONTRACT_DIR}/${MODULE_NAME}/spec/index.yaml'
outputDir: '${OUTPUT_DIR}/${MODULE_NAME}/server'
apiPackage: '${BASE_PACKAGE}.${MODULE_NAME}.api'
modelPackage: '${BASE_PACKAGE}.${MODULE_NAME}.model'
invokerPackage: '${BASE_PACKAGE}.${MODULE_NAME}.api.invoker'
EOF

yq eval-all '. as $item ireduce ({}; . *+ $item)' ${MODULE_NAME}.yml server.yaml
