#!/bin/bash
VERSION="$(cat VERSION)"
OUTPUT_NAME="$(basename "$(git rev-parse --show-toplevel)")"
PACKAGE_VERSION=${VERSION}-${1:-101}
PROJECT_NAME=hypriot-cluster-lab
PACKAGE_NAME="${PROJECT_NAME}_${PACKAGE_VERSION}"
TIMESTAMP="$(date +"%Y-%m-%d_%H%M")"
REPO="$(git rev-parse --short HEAD)"
BUILD_RESULTS=./buildresult
BUILD_DIR=${BUILD_RESULTS}/arm-binaries/${PROJECT_NAME}/${TIMESTAMP}_${REPO}
DESCRIPTION="$(cat DESCRIPTION)"
DEPENDENCIES="$(cat DEPENDENCIES)"

mkdir -p ${BUILD_DIR}/package/${PACKAGE_NAME}
cp -r package/* ${BUILD_DIR}/package/${PACKAGE_NAME}/
sed -i'' "s/<VERSION>/${PACKAGE_VERSION}/g" ${BUILD_DIR}/package/${PACKAGE_NAME}/DEBIAN/control
sed -i'' "s/<NAME>/hypriot-${OUTPUT_NAME}/g" ${BUILD_DIR}/package/${PACKAGE_NAME}/DEBIAN/control
sed -i'' "s/<SIZE>/60/g" ${BUILD_DIR}/package/${PACKAGE_NAME}/DEBIAN/control
sed -i'' "s/<DESCRIPTION>/${DESCRIPTION}/g" ${BUILD_DIR}/package/${PACKAGE_NAME}/DEBIAN/control
sed -i'' "s/<DEPENDS>/${DEPENDENCIES}/g" ${BUILD_DIR}/package/${PACKAGE_NAME}/DEBIAN/control
cd ${BUILD_DIR}/package && dpkg-deb --build ${PACKAGE_NAME}
cd -
rm -rf ${BUILD_DIR}/package/${PACKAGE_NAME}

scp ${BUILD_DIR}/package/${PACKAGE_NAME}.deb pirate@black-pearl-1.local:./
scp ${BUILD_DIR}/package/${PACKAGE_NAME}.deb pirate@black-pearl-2.local:./
scp ${BUILD_DIR}/package/${PACKAGE_NAME}.deb pirate@black-pearl-3.local:./
