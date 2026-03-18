#!/usr/bin/env bash
set -euo pipefail

cd /repo

export LOGICA_STATE_DIR="/tmp/logica-test"
export LOGICA_CONFIG_PATH="${LOGICA_STATE_DIR}/logica.json"

echo "==> Build"
pnpm build

echo "==> Seed state"
mkdir -p "${LOGICA_STATE_DIR}/credentials"
mkdir -p "${LOGICA_STATE_DIR}/agents/main/sessions"
echo '{}' >"${LOGICA_CONFIG_PATH}"
echo 'creds' >"${LOGICA_STATE_DIR}/credentials/marker.txt"
echo 'session' >"${LOGICA_STATE_DIR}/agents/main/sessions/sessions.json"

echo "==> Reset (config+creds+sessions)"
pnpm logica reset --scope config+creds+sessions --yes --non-interactive

test ! -f "${LOGICA_CONFIG_PATH}"
test ! -d "${LOGICA_STATE_DIR}/credentials"
test ! -d "${LOGICA_STATE_DIR}/agents/main/sessions"

echo "==> Recreate minimal config"
mkdir -p "${LOGICA_STATE_DIR}/credentials"
echo '{}' >"${LOGICA_CONFIG_PATH}"

echo "==> Uninstall (state only)"
pnpm logica uninstall --state --yes --non-interactive

test ! -d "${LOGICA_STATE_DIR}"

echo "OK"
