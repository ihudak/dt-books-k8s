#!/bin/sh
clear
echo "=============================================="

SCRIPT_DIR="$( dirname -- "$0"; )"
SCRIPT_DIR=$SCRIPT_DIR/../dt-books-k8s

PREFIX=dt-books-

dt_projects="clients books cart storage orders ratings payment dynapay dataloader"

echo "============ Building Projects ================="
for i in $dt_projects; do
  PROJ_DIR=$PREFIX$i
  cd $SCRIPT_DIR/../$PROJ_DIR
  echo "Building " $i ...
  ./gradlew clean build
done

