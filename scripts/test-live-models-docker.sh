#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
IMAGE_NAME="${LOGICA_IMAGE:-${CLAWDBOT_IMAGE:-logica:local}}"
CONFIG_DIR="${LOGICA_CONFIG_DIR:-${CLAWDBOT_CONFIG_DIR:-$HOME/.logica}}"
WORKSPACE_DIR="${LOGICA_WORKSPACE_DIR:-${CLAWDBOT_WORKSPACE_DIR:-$HOME/.logica/workspace}}"
PROFILE_FILE="${LOGICA_PROFILE_FILE:-${CLAWDBOT_PROFILE_FILE:-$HOME/.profile}}"

PROFILE_MOUNT=()
if [[ -f "$PROFILE_FILE" ]]; then
  PROFILE_MOUNT=(-v "$PROFILE_FILE":/home/node/.profile:ro)
fi

echo "==> Build image: $IMAGE_NAME"
docker build -t "$IMAGE_NAME" -f "$ROOT_DIR/Dockerfile" "$ROOT_DIR"

echo "==> Run live model tests (profile keys)"
docker run --rm -t \
  --entrypoint bash \
  -e COREPACK_ENABLE_DOWNLOAD_PROMPT=0 \
  -e HOME=/home/node \
  -e NODE_OPTIONS=--disable-warning=ExperimentalWarning \
  -e LOGICA_LIVE_TEST=1 \
  -e LOGICA_LIVE_MODELS="${LOGICA_LIVE_MODELS:-${CLAWDBOT_LIVE_MODELS:-all}}" \
  -e LOGICA_LIVE_PROVIDERS="${LOGICA_LIVE_PROVIDERS:-${CLAWDBOT_LIVE_PROVIDERS:-}}" \
  -e LOGICA_LIVE_MODEL_TIMEOUT_MS="${LOGICA_LIVE_MODEL_TIMEOUT_MS:-${CLAWDBOT_LIVE_MODEL_TIMEOUT_MS:-}}" \
  -e LOGICA_LIVE_REQUIRE_PROFILE_KEYS="${LOGICA_LIVE_REQUIRE_PROFILE_KEYS:-${CLAWDBOT_LIVE_REQUIRE_PROFILE_KEYS:-}}" \
  -v "$CONFIG_DIR":/home/node/.logica \
  -v "$WORKSPACE_DIR":/home/node/.logica/workspace \
  "${PROFILE_MOUNT[@]}" \
  "$IMAGE_NAME" \
  -lc "set -euo pipefail; [ -f \"$HOME/.profile\" ] && source \"$HOME/.profile\" || true; cd /app && pnpm test:live"
