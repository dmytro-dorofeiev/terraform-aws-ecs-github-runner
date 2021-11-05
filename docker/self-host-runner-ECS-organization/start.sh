#!/bin/bash
set -e

./config.sh --url https://github.com/${ORG} --token "${PAT}" --name "aws-runner" --labels aws-runner --unattended --replace
./bin/runsvc.sh