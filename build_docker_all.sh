#!/bin/sh
clear
echo "=============================================="

SCRIPT_DIR="$( dirname -- "$0"; )"
SCRIPT_DIR=$SCRIPT_DIR/../dt-books-k8s
JAR_FILE=build/libs/*0.0.1-SNAPSHOT.jar

PREFIX=dt-books-
DT_JAVA_AGENT=$PREFIX\java-agents
DT_NO_AGENT=$PREFIX\noagents
DT_GUI=$PREFIX\gui

dt_projects="clients books cart storage orders ratings payment dynapay dataloader"

cd $SCRIPT_DIR/../$DT_JAVA_AGENT
echo "============ Building Agents ================="
./push_docker.sh
cd $SCRIPT_DIR/../$DT_NO_AGENT
echo "============ Building NoAgent ================="
./push_docker.sh
cd $SCRIPT_DIR/../$DT_GUI
echo "============ Building GUI ================="
./push_docker.sh

echo "============ Building Projects ================="
for i in $dt_projects; do
  PROJ_DIR=$PREFIX$i
  cd $SCRIPT_DIR/../$PROJ_DIR
  if [ ! -f $JAR_FILE ]; then
    echo "Building " $i ...;
    ./gradlew clean build;
  else
    echo; echo "No Gradle build is needed for " $i". File exists " $JAR_FILE; echo;
  fi
  echo "x64 NoAg"
  $SCRIPT_DIR/push_docker.sh $i -noagent
  echo "x64 Ag"
  $SCRIPT_DIR/push_docker.sh $i -agents
  echo "ARM NoAg"
  $SCRIPT_DIR/push_docker.sh $i -noagent -arm
  echo "ARM Ag"
  $SCRIPT_DIR/push_docker.sh $i -agents -arm
done

