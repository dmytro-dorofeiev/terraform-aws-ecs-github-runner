#!/bin/bash
set -e

AUTH_HEADER="Authorization: token ${PAT}"
API_VERSION=v3
API_HEADER="Accept: application/vnd.github.${API_VERSION}+json"
_FULL_URL="https://api.github.com/repos/${GITHUB_OWNER}/${GITHUB_REPOSITORY}/actions/runners/registration-token"
RUNNER_TOKEN="$(curl -XPOST -fsSL \
  -H "${AUTH_HEADER}" \
  -H "${API_HEADER}" \
  "${_FULL_URL}" \
| jq -r '.token')"

./config.sh \
    --name "$(hostname)" \
    --token "${RUNNER_TOKEN}" \
    --url https://github.com/"${GITHUB_OWNER}"/"${GITHUB_REPOSITORY}" \
    --work "${RUNNER_WORKDIR}" \
    --labels aws-runner \
    --unattended \
    --replace

./bin/runsvc.sh
