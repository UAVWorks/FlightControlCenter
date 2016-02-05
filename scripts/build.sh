#!/bin/bash

if [ $# != 3 ]; then
   echo "Error! Please provide 3 parameters"
   echo "FGAP_SRC_DIR, FGAP_INSTALL_DIR, BUILD_VARIANT"
   exit 1
fi

ROOT_DIR=$(cd $(dirname $0) && pwd)
FGAP_SRC_DIR=$1
FGAP_INSTALL_DIR=$2
BUILD_VARIANT=$3     # release or debug

qbs setup-toolchains --detect
qbs setup-qt --detect
qbs setup-qt $(which qmake) qt
qbs config defaultProfile qt

qbs build                             \
    --file $FGAP_SRC_DIR/src          \
    --command-echo-mode command-line  \
    --clean-install-root              \
    --build-directory /tmp/fgap_build \
    qbs.installRoot:$FGAP_INSTALL_DIR \
    $BUILD_VARIANT

python -u $FGAP_SRC_DIR/scripts/deployqt.py                                  \
          --app_file      $FGAP_INSTALL_DIR/FlightGear_Autopilot/fgautopilot \
          --install_dir   $FGAP_INSTALL_DIR/FlightGear_Autopilot             \
          --data_dir      $FGAP_INSTALL_DIR/FlightGear_Autopilot/data        \
          --libraries_dir $FGAP_INSTALL_DIR/FlightGear_Autopilot/data/lib    \
          --qmake         $(which qmake)                                     \
          --debug_build   $BUILD_VARIANT