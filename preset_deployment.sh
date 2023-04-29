#!/bin/bash

display_usage() {
  echo "Bad/no argument(s) supplied";
      echo "Sets agent instrumentation and architecture in the deployment yaml files"
      echo "Usage:";
      echo "   ./preset_deployment.sh -agents  -arm|-x64  # makes docker image with OA and OTel agents";
      echo "   ./preset_deployment.sh -noagent -arm|-x64  # makes docker image with no agents embedded";
      echo;
      echo "Please supply at least either -agents or -noagent";
      echo "      optionally specify platform as -arm or -x64";
      echo "      default platform is x64";
	  echo;
      exit 1;
}

if [ $# -lt 2 ]; then
  display_usage;
elif [ $2 != "-agents" ] && [ $2 != "-noagent" ]; then
  display_usage;
fi

if [ $2 = "-agents" ]; then AGENT=agents; else AGENT=noagent; fi

if [ $# -eq 3 ] && [ $3 = "-arm" ]; then
  PLATFORM="arm64";
else
  PLATFORM="x64";
fi
