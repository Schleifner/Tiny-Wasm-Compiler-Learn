#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "${ROOT_DIR}"

MODE="${1:-check}"
shift || true

DICT_FILE="${ROOT_DIR}/cspell/project-words.txt"
CI_NODE_MAJOR="18"
CSPELL_VERSION="8"
PRETTIER_VERSION="3"
CHECK_GLOB="**/*.md"

usage() {
  cat <<'EOF'
Usage:
  scripts/pre-commit-check.sh check
  scripts/pre-commit-check.sh fix [--add-word WORD ...]
  scripts/pre-commit-check.sh ci

Modes:
  check   CI-parity checks: cspell@8 + prettier@3 on "**/*.md"
  fix     Run prettier@3 --write on "**/*.md", then cspell@8 check
          (optional) add allow-list words into cspell/project-words.txt
  ci      Alias of check (kept for clarity)

Examples:
  scripts/pre-commit-check.sh check
  scripts/pre-commit-check.sh ci
  scripts/pre-commit-check.sh fix
  scripts/pre-commit-check.sh fix --add-word wasmjit aarch64local
EOF
}

if [[ "${MODE}" == "ci" ]]; then
  MODE="check"
fi

if [[ "${MODE}" != "check" && "${MODE}" != "fix" ]]; then
  usage
  exit 1
fi

if command -v node >/dev/null 2>&1; then
  NODE_MAJOR="$(node -p 'process.versions.node.split(".")[0]')"
  if [[ "${NODE_MAJOR}" != "${CI_NODE_MAJOR}" ]]; then
    echo "WARNING: CI uses Node.js ${CI_NODE_MAJOR}, but local node is ${NODE_MAJOR}."
  fi
else
  echo "WARNING: node is not installed; npx-based checks may fail."
fi

EXTRA_WORDS=()
if [[ "${MODE}" == "fix" && "${1:-}" == "--add-word" ]]; then
  shift
  if [[ $# -eq 0 ]]; then
    echo "ERROR: --add-word requires at least one word." >&2
    exit 1
  fi
  EXTRA_WORDS=("$@")
fi

echo "==> Running CI-aligned checks (cspell@${CSPELL_VERSION}, prettier@${PRETTIER_VERSION})"

if [[ "${MODE}" == "fix" && ${#EXTRA_WORDS[@]} -gt 0 ]]; then
  echo "==> Adding words to ${DICT_FILE}"
  for w in "${EXTRA_WORDS[@]}"; do
    echo "${w}" >> "${DICT_FILE}"
  done
  awk 'NF' "${DICT_FILE}" | LC_ALL=C sort -u > "${DICT_FILE}.tmp"
  mv "${DICT_FILE}.tmp" "${DICT_FILE}"
fi

if [[ "${MODE}" == "fix" ]]; then
  echo "==> Running prettier --write ${CHECK_GLOB}"
  npx --yes "prettier@${PRETTIER_VERSION}" --write "${CHECK_GLOB}"
else
  echo "==> Running prettier --check ${CHECK_GLOB}"
  npx --yes "prettier@${PRETTIER_VERSION}" --check "${CHECK_GLOB}"
fi

echo "==> Running cspell ${CHECK_GLOB}"
npx --yes "cspell@${CSPELL_VERSION}" "${CHECK_GLOB}"

if [[ "${MODE}" == "fix" ]]; then
  echo "Done. Note: cspell does not auto-correct typos; fix misspellings manually or use --add-word."
else
  echo "All checks passed."
fi
