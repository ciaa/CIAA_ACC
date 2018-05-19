#!/bin/bash
set -e

BR_VERSION=2017.08.1
BR_URL=https://buildroot.org/downloads/buildroot-${BR_VERSION}.tar.gz
BR_TARGZ=$(basename ${BR_URL})
BR_DIR=$(basename ${BR_URL} .tar.gz)
BASE_DIR=$(dirname $(readlink -f $0))
PATCH_FILE=${BASE_DIR}/buildroot.patch

wget ${BR_URL} -O ${BR_TARGZ}
tar -xf ${BR_TARGZ}
(cd ${BR_DIR}
patch -p1 < ${PATCH_FILE}
chmod a+x board/ciaa/acc/post-build.sh
make zynq_ciaa_acc_defconfig
)
