#!/bin/bash
set -e

./config.sh \
  --url https://github.com/${ORG} \
  --pat "${PAT}" \
  --name "$(hostname)" \
  --labels "${LABEL}" \
  --unattended \
  --replace \
  --ephemeral

./bin/runsvc.sh
