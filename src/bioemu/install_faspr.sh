#!/bin/bash
set -ex

FASPR_EXECUTABLE=${1:-"${HOME}/FASPR/FASPR"}
# Skip if the executable exists already
if [ -f ${FASPR_EXECUTABLE} ]; then
    echo "FASPR already installed at ${FASPR_INSTALL_DIR}"
    exit 0
fi

FASPR_REPO_DIR=${HOME}/FASPR_code

if [ -d ${FASPR_REPO_DIR} ]; then
    echo "FASPR repo already exists at ${FASPR_REPO_DIR}"
else
    echo "FASPR repo does not exist at ${FASPR_REPO_DIR}, cloning..."
    git clone git@github.com:tommyhuangthu/FASPR.git ${FASPR_REPO_DIR}
fi

# create the parent directory of FASPR_EXECUTABLE
FASPR_EXECUTABLE_DIR=$(dirname ${FASPR_EXECUTABLE})
if [ ! -d ${FASPR_EXECUTABLE_DIR} ]; then
    mkdir -p ${FASPR_EXECUTABLE_DIR}
fi
cd ${FASPR_REPO_DIR}
g++ -w -O3 --fast-math -o $FASPR_EXECUTABLE src/*.cpp

cp ${FASPR_REPO_DIR}/dun2010bbdep.bin ${FASPR_EXECUTABLE_DIR}
chmod +x ${FASPR_REPO_DIR}/dun2010bbdep.bin