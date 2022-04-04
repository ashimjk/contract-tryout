#!/bin/sh

SCRIPT_DIR="$(cd "$(dirname "${0}")" && pwd)"
SCRIPT_DIR="$(dirname ${SCRIPT_DIR})"
cd $SCRIPT_DIR

CI_BUILD_TAG="v1.2.3"

exit_if_error_found() {
  if [ $? -ne 0 ]; then
    exit $?
  fi
}

maven_deploy() {
  echo "\n\n=================================================================="
  echo "Publishing contract for module: ${module} - ${1}"
  echo "=================================================================="

  cd $SCRIPT_DIR/${CONTRACT_OUTPUT_DIR}/${module}/$1

  sed -i "s|</project>|<distributionManagement><repository><id>RELEASES</id><name>RELEASES</name><url>https://artifactory.progressoft.io/artifactory/PS-Releases</url></repository><snapshotRepository><id>CORPAY-SNAPSHOTS</id><name>CORPAY-SNAPSHOTS</name><url>https://nexus.corporate-dev.progressoft.cloud/repository/corpay-maven-repo/</url></snapshotRepository></distributionManagement></project>|" pom.xml

  mvn -B build-helper:parse-version versions:set -DprocessAllModules=true -DnewVersion=${CI_BUILD_TAG} versions:commit
  #  mvn source:jar-no-fork deploy -DskipTests -s ./cicd/settings.xml
  exit_if_error_found
}

npm_publish() {
  echo "\n\n=================================================================="
  echo "Publishing contract for module: ${module} - ${1}"
  echo "=================================================================="

  cd $SCRIPT_DIR/${CONTRACT_OUTPUT_DIR}/${module}/$1

  cd dist/ &&
    npm version ${CI_BUILD_TAG} --no-git-tag-version &&
    npm pack
  #     && npm publish
  exit_if_error_found
}

echo "------------BEGIN: PUBLISH CONTRACT------------"

. ./cicd/configs/common.config

modules=$(sh ./cicd/modules.sh)
for module in $modules; do
  maven_deploy ${SERVER_GENERATOR_TYPE}
  maven_deploy ${SERVER_CLIENT_GENERATOR_TYPE}
  npm_publish ${WEB_CLIENT_GENERATOR_TYPE}
done

echo "------------SUCCESS: PUBLISH CONTRACT------------"
#
