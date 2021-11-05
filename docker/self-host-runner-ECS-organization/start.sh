#!/bin/bash
set -e

./config.sh \
  --url https://github.com/${ORG} \
  --token "${PAT}" \
  --name "$(hostname)" \
  --labels aws-runner \
  --unattended \
  --replace

./bin/runsvc.sh
