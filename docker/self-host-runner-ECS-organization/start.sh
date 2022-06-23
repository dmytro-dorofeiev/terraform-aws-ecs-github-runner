#!/bin/bash
set -e

./config.sh \
  --url https://github.com/${ORG} \
  --token "${PAT}" \
  --name "$(hostname)" \
  --labels "${LABEL}" \
  --unattended \
  --replace

./bin/runsvc.sh
