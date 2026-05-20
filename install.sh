#!/usr/bin/env bash
set -uo pipefail

STATE_FILE="$HOME/.mytermux-state"
AUTO_ACCEPT=false
RESET_STATE=false
DRY_RUN=false

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

HELPERS=(
  colors animation banner package switchcase
  dotfiles clone nvchad utility
  stat signal cursor finish
)

for HELPER in "${HELPERS[@]}"; do
  source "${SCRIPT_DIR}/helper/${HELPER}.sh"
done

function usage() {
  echo "Usage: $0 [OPTIONS]"
  echo ""
  echo "Options:"
  echo "  -y, --yes       Auto-accept all prompts"
  echo "  -r, --reset     Clear saved state and run all steps"
  echo "  -n, --dry-run   Show what would be done without making changes"
  echo "  -h, --help      Show this help message"
  exit 0
}

function parseArgs() {
  while [[ $# -gt 0 ]]; do
    case "$1" in
      -y|--yes)
        AUTO_ACCEPT=true
        shift
        ;;
      -r|--reset)
        RESET_STATE=true
        shift
        ;;
      -n|--dry-run)
        DRY_RUN=true
        shift
        ;;
      -h|--help)
        usage
        ;;
      *)
        echo "Unknown option: $1"
        usage
        ;;
    esac
  done
}

function isStepDone() {
  [[ -f "$STATE_FILE" ]] && grep -q "^$1$" "$STATE_FILE"
}

function markStepDone() {
  echo "$1" >> "$STATE_FILE"
}

function runStep() {
  local step_name="$1"
  local step_func="$2"

  if [[ "$DRY_RUN" == true ]]; then
    stat "DRY-RUN" "Info" "Would run: $step_name"
    return 0
  fi

  if isStepDone "$step_name"; then
    stat "SKIPPED" "Info" "$step_name (already done, use -r to reset)"
    return
  fi

  $step_func

  if [[ $? -eq 0 ]]; then
    markStepDone "$step_name"
  fi
}

function main() {

  parseArgs "$@"

  if [[ "$RESET_STATE" == true ]]; then
    rm -f "$STATE_FILE"
    stat "RESET" "Info" "State cleared, running all steps"
  fi

  trap 'handleInterruptByUser "Interrupt by User"' 2

  clear
  banner

  runStep "packages" "installPackages"
  runStep "backup" "backupDotFiles"
  runStep "dotfiles" "installDotFiles"
  runStep "clone" "cloneRepository"

  runStep "nvchad" "NvChad"
  runStep "utility" "utility"

  mainAlert

}

main "$@"
